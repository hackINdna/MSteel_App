import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:marquee/marquee.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final stocksData = [
    'AAPL: \$143.16',
    'GOOG: \$2,057.24',
    'AMZN: \$3,222.90',
    'TSLA: \$739.78',
  ];

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('msteel_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  notificationDetails() {
    final stocksMarquee = Marquee(
      text: stocksData.join('   |   '),
      style: TextStyle(fontSize: 16.0),
      blankSpace: 80.0,
      velocity: 40.0,
      pauseAfterRound: Duration(seconds: 1),
    );
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
        ongoing: true,
        ticker: 'Stock Data ticker',
        styleInformation: BigTextStyleInformation(
          stocksMarquee.text,
          contentTitle: 'Stocks data',
          htmlFormatContentTitle: true,
        ),
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    final stocksMarquee = Marquee(
      text: stocksData.join('   |   '),
      style: TextStyle(fontSize: 16.0),
      blankSpace: 80.0,
      velocity: 40.0,
      pauseAfterRound: Duration(seconds: 1),
    );
    return flutterLocalNotificationsPlugin.show(
      id,
      "Stocks Data",
      stocksMarquee.text,
      await notificationDetails(),
    );
  }
  // Future showNotification(
  //     {int id = 0, String? title, String? body, String? payload}) async {
  //   return flutterLocalNotificationsPlugin.show(
  //       id, title, body, await notificationDetails());
  // }
}
