import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/notification_service.dart';
import '../../core/utils/constants/app_colors.dart';
import '../../core/widget/custom_dialog.dart';
import 'task_controller.dart';

class TaskListScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: const Text('To-Do List'),
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(task.imagePath ?? '')),
                            )),
                      ),
                      // SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  task.title??'',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: task.isDone?Colors.grey:Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: task.isDone?TextDecoration.lineThrough:TextDecoration.none,
                                    decorationColor: task.isDone?Colors.grey:null,
                                  ),
                                ),
                                Checkbox(
                                  activeColor: AppColors.primary,
                                  value: task.isDone,
                                  onChanged: (value) {
                                    task.isDone = value!;
                                    taskController.updateTask(task);
                                    NotifyHelper.showInstantNotification(
                                      task.isDone?'Your task is complete':'Your task not complete',
                                      task.isDone?'Your can take another Task':'Your can take another Task',
                                    );
                                  },
                                ),
                              ],
                            ),
                            Text(
                              'description',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade400),
                            ),
                            const Spacer(),
                            FittedBox(
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Time',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              task.dueTime??'',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        builder: (_) => TodoDialog(
                                        task: task,
                                        isEdit: true,
                                      ));
                                    },
                                    child: Container(
                                      width: 90,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Edit',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),

                                          ),
                                          SizedBox(width: 5),
                                          Icon(Icons.edit,color: Colors.white,size: 14,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete,size: 30,),
                                    onPressed: () {
                                      taskController.deleteTask(task.id!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          color: AppColors.secondary,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => TodoDialog(
              isEdit: false,
            ),
          );
        },
      ),
    );
  }
}
