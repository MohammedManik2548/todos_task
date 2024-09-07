import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../presentation/task_list_screen/task_controller.dart';
import '../../data/models/task_model.dart';
import '../utils/constants/app_colors.dart';
import '../utils/utils.dart';

class TodoDialog extends StatefulWidget {
  final Task? task;
  final bool isEdit;

  TodoDialog({this.task, required this.isEdit});

  @override
  _TodoDialogState createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController duTime = TextEditingController();
  final TextEditingController sTime = TextEditingController();
  final TaskController taskController = Get.find();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String? imageFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      titleController.text = widget.task!.title;
      // descriptionController.text = widget.task!.description;
      if (widget.task!.imagePath != null) {
        imageFile = widget.task!.imagePath!;
      }
    }
  }

  Future<void> pickImage() async {
    var status = await Utils.storagePermission();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (status) {
      if (pickedFile != null) {
        setState(() {
          imageFile = pickedFile?.path;
        });
      }
    }
  }

  _getTimeForUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time Canceld");
    } else if (isStartTime == true) {
      setState(() {
        duTime.text = formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        sTime.text = formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(startTime.split(":")[0]),
        minute: int.parse(startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEdit ? 'Edit Todo' : 'Add Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              _getTimeForUser(isStartTime: true);
            },
            child: TextField(
              controller: duTime,
              enabled: false,
              decoration: InputDecoration(labelText: 'Start Time'),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              _getTimeForUser(isStartTime: false);
            },
            child: TextField(
              controller: sTime,
              enabled: false,
              decoration: InputDecoration(labelText: 'End Time'),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: pickImage,
            child: imageFile != null
                ? Image.file(
                    File(imageFile!),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: Icon(Icons.camera_alt, size: 50),
                  ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
        TextButton(
          onPressed: () {
            if (widget.isEdit) {
              var updatedTodo = Task(
                id: widget.task!.id,
                title: titleController.text,
                dueTime: duTime.text,
                imagePath: imageFile!,
              );
              taskController.updateTask(updatedTodo);
            } else {
              var newTodo = Task(
                title: titleController.text,
                dueTime: duTime.text,
                imagePath: imageFile ?? '',
              );
              taskController.addTask(newTodo);
            }
            Navigator.pop(context);
          },
          child: Text(
            widget.isEdit ? 'Update' : 'Add',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

}
