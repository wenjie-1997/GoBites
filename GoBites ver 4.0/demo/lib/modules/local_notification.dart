import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterNotificationPlugin;
  static AndroidNotificationDetails androidSettings;

  static Initializer() {
    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();
    androidSettings = AndroidNotificationDetails(
        "111", "Background_task_Channel", "Channel to test background task",
        importance: Importance.high, priority: Priority.max);
    var androidInitialization = AndroidInitializationSettings('app_icon');
    var initializationSettings =
        InitializationSettings(android: androidInitialization, iOS: null);
    flutterNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: onNotificationSelect);
  }

  static Future<void> onNotificationSelect(String payload) async {
    print(payload);
  }

  static ShowOneTimeNotification(DateTime scheduledDate) async {
    var notificationDetails =
        NotificationDetails(android: androidSettings, iOS: null);
    // ignore: deprecated_member_use
    await flutterNotificationPlugin.schedule(1, "GoBites",
        "Welcome to our food delivery app", scheduledDate, notificationDetails,
        androidAllowWhileIdle: true);
  }

  static DeliveryNotification(DateTime scheduledDate) async {
    var notificationDetails =
        NotificationDetails(android: androidSettings, iOS: null);
    // ignore: deprecated_member_use
    await flutterNotificationPlugin.schedule(1, "GoBites",
        "Your food is being delivered", scheduledDate, notificationDetails,
        androidAllowWhileIdle: true);
  }

  static DeliveredNotification(DateTime scheduledDate) async {
    var notificationDetails =
        NotificationDetails(android: androidSettings, iOS: null);
    // ignore: deprecated_member_use
    await flutterNotificationPlugin.schedule(1, "GoBites",
        "Your food is delivered", scheduledDate, notificationDetails,
        androidAllowWhileIdle: true);
  }
}
