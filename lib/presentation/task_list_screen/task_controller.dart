import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'dart:io';

import '../../core/services/notification_service.dart';
import '../../data/models/task_model.dart'; // Assuming task_model.dart contains Task class definition

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  late Database database;

  @override
  void onInit() async{
    super.onInit();
    initDatabase();
    await NotifyHelper.init();
    tz.initializeTimeZones();
  }

  void initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'task_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, dueTime TEXT, imagePath TEXT, isDone INTEGER)',
        );
      },
      version: 1,
    );
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final List<Map<String, dynamic>> maps = await database.query('tasks');
    tasks.value = List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        dueTime: maps[i]['dueTime'],
        imagePath: maps[i]['imagePath'],
        isDone: maps[i]['isDone'] == 1,
      );
    });
  }

  Future<void> addTask(Task task) async {
    await database.insert('tasks', task.toMap());
    fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await database
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
    fetchTasks();
  }


  Future<void> deleteTask(int id) async {
    await database.delete('tasks', where: 'id = ?', whereArgs: [id]);
    fetchTasks();
  }


  // // Method to schedule notification
  // void _scheduleNotification(Task task) async {
  //   var scheduledNotificationDateTime =
  //   DateTime.parse(task.dueTime); // Assuming dueTime is a DateTime string
  //
  //   // Define notification details
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'task_reminder_channel', // id
  //     'Task Reminder', // title
  //     'Channel for task reminder notifications', // description
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //   );
  //
  //   // Schedule notification at task's due time
  //   await flutterLocalNotificationsPlugin.schedule(
  //     task.id!, // Notification id (can be task id)
  //     'Task Reminder',
  //     'Reminder: ${task.title} is due!',
  //     scheduledNotificationDateTime,
  //     platformChannelSpecifics,
  //     payload: task.id.toString(), // Pass task id as payload to open task details when clicked
  //   );
  // }

}
