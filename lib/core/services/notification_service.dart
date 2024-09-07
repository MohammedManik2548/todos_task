import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
class NotifyHelper{
  // initialize the FlutterLocalNotificationPlugin instance
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(); //

  static Future<void> onDidReceiveNotification(NotificationResponse notificationResponse)async{

  }

 // Initialize the notification plugin
 static Future<void> init()async{
   // define the android initialization settings
   const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
   // define the ios initialization settings
   const DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings();

   const InitializationSettings initializationSettings = InitializationSettings(
     android: androidInitializationSettings,
     iOS: iosInitializationSettings,
   );

   await flutterLocalNotificationsPlugin.initialize(
       initializationSettings,
     onDidReceiveNotificationResponse: onDidReceiveNotification,
     onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
   );

   await flutterLocalNotificationsPlugin
       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
       ?.requestNotificationsPermission();
 }
 static Future<void> showInstantNotification(String title, String body)async{

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
          "channel_Id",
          "channel_name",
        importance: Importance.high,
        priority: Priority.high),
      iOS: DarwinNotificationDetails()
    );
    await flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        platformChannelSpecifics,
    );
 }
 static Future<void> scheduledNotification(String title, String body, DateTime selectedTime)async{

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
          "channel_Id",
          "channel_name",
        importance: Importance.high,
        priority: Priority.high),
      iOS: DarwinNotificationDetails()
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.from(selectedTime, tz.local),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
 }


}