// CSCI 4100U - 08 Complete App

import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:chorganizer/chore_list.dart';

class Notifications {
  final channelId = 'chorganizerNotifications';
  final channelName = 'Chorganizer Notifications';
  final channelDescription = 'Chorganizer Notification Channel';

  BuildContext _context;
  var _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  NotificationDetails _platformChannelInfo;
  var _notificationId = 1;

  void init(BuildContext context) {
    this._context = context;

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    // setup a channel for notifications
    var androidPlatformChannelInfo = AndroidNotificationDetails(
        channelId, channelName, channelDescription,
        importance: Importance.defaultImportance, priority: Priority.defaultPriority, ticker: 'ticker');

    var iOSPlatformChannelInfo = IOSNotificationDetails();
    _platformChannelInfo = NotificationDetails(
        android: androidPlatformChannelInfo, iOS: iOSPlatformChannelInfo);
  }

  Future<dynamic> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    return null;
  }

  Future onSelectNotification(var payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
    await Navigator.push(
      this._context,
      new MaterialPageRoute(builder: (context) => ChoreList(/*payload*/)),
    );
  }

  void cancelNotification(int id) {
    _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<int> sendNotificationNow(
      int notificationId, String title, String body, String payload) async {
    await _flutterLocalNotificationsPlugin.show(
        notificationId, title, body, _platformChannelInfo,
        payload: payload);
    return notificationId;
  }

  Future<int> sendNotificationLater(int notificationId, String title,
      String body, DateTime when, String payload) async {
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, when.year, when.month, when.day, when.hour, when.minute);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId, title, body, scheduledDate, _platformChannelInfo,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
    /*
    await _flutterLocalNotificationsPlugin.schedule(
        notificationId, title, body, when, _platformChannelInfo);
    */
    return notificationId;
  }

  Future<int> scheduleDailyNotification(int notificationId, String title,
      String body, Time time, String payload) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId, title, body, scheduledDate, _platformChannelInfo,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      notificationId, 
      title,
      body, 
      RepeatInterval.daily, 
      _platformChannelInfo,
      androidAllowWhileIdle: true);
    /* // deprecated code:
    await _flutterLocalNotificationsPlugin.showDailyAtTime(
        notificationId, title, body, time, _platformChannelInfo);
    */
    return notificationId;
  }

  Future<int> scheduleWeeklyNotification(int notificationId, String title,
      String body, Day day, Time time, String payload) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId, title, body, scheduledDate, _platformChannelInfo,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      notificationId, 
      title,
      body, 
      RepeatInterval.weekly, 
      _platformChannelInfo,
      androidAllowWhileIdle: true);
    /*
    await _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        notificationId, title, body, day, time, _platformChannelInfo);
    */
    return notificationId;
  }
}
