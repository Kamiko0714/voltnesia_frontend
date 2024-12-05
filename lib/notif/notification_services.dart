import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future cancelNotification(int id) => _notification.cancel(id);
  static Future cancelAllNotification() => _notification.cancelAll();
  static Future cancelNotificationByTag(String tag) =>
      _notification.cancel(0, tag: tag);
  
  static Future<void> init({
    bool initScheduled = false,
  }) async {
    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid = 
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Common initialization settings
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initialize the plugin
    await _notification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        print('Notification payload: $payload');
      },
    );

    // Daftarkan channel untuk suara kustom
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'alarm_channel_id', // ID unik untuk channel
      'Alarm Notifications', // Nama channel
      description: 'This channel is used for alarm notifications.',
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('notification_sound'), // Nama file tanpa ekstensi
      playSound: true,
    );

    await _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future selectNotification(String? payload) async {
    if (payload != null) {
      print('Notification payload: $payload');
    }
  }

  static Future showNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) =>
      _notification.show(
        id,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
            playSound: true,
            sound: RawResourceAndroidNotificationSound('notification_sound'), // Add custom sound
          ),
        ),
        payload: payload,
      );

  static Future scheduledNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required TimeOfDay scheduledTime,
  }) async {
    await _notification.zonedSchedule(
      id,
      title,
      body,
      _scheduledDaily(scheduledTime),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel_id', // Pastikan ID channel sesuai
          'Alarm Notifications',
          channelDescription: 'This channel is used for alarm notifications.',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('notification_sound'), // Nama file suara tanpa ekstensi
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _scheduledDaily(TimeOfDay time) {
    final jakarta = tz.getLocation('Asia/Jakarta');
    tz.setLocalLocation(jakarta);
    final now = tz.TZDateTime.now(jakarta);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute, 0);

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }
}

class NotificationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _requestNotificationPermission();
  }

  Future<void> _requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    if (await Permission.notification.isGranted) {
      print("Notification permission granted");
    } else {
      print("Notification permission denied");
      // Show a dialog or message to inform the user
    }
  }

  static void init() {}
}