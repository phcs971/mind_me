import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:mind_me/src/stores/config.store.dart';
import 'package:mind_me/src/widgets/snackbar.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'service.dart';
import '../utils.dart';
import '../models/note.model.dart';
import '../stores/notes.store.dart';
import '../widgets/note.widget.dart';

class NotificationService {
  final plugin = FlutterLocalNotificationsPlugin();
  final nav = Get.find<NavigationService>();

  int notificationId = 0;

  Future init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notificationId = prefs.getInt("mind-me-notification-id") ?? 0;
    const androidSettings = AndroidInitializationSettings('note_icon');
    final iosSettings = IOSInitializationSettings();
    final settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await plugin.initialize(settings, onSelectNotification: onSelect);
  }

  Future onSelect(String? payload) async {
    if (payload == null) return;
    await Get.find<StartupService>().start();
    final note = Get.find<NotesStore>().byId(payload);
    if (note != null)
      NoteDialog(note).open();
    else
      SnackbarWidget.error(MindMeTexts.baseError.tr);
  }

  Future<List<int>?> create(NoteModel note) async {
    if (!note.notify || !Get.find<ConfigStore>().sendNotifications) return null;
    try {
      final ids = <int>[];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final android = AndroidNotificationDetails(
        'mind-me-channel',
        MindMeTexts.mindMe.tr,
        MindMeTexts.mindMe.tr,
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      );

      final platformChannelSpecifics = NotificationDetails(android: android);

      final now = DateTime.now();
      int weekday = now.weekday;
      if (weekday == 7) weekday = 0;

      tz.initializeTimeZones();
      final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName!));
      for (var i = 0; i < 7; i++) {
        if (!note.dates[i]) continue;
        DateTime date = DateTime(now.year, now.month, now.day, note.time.hour, note.time.minute);
        if (i < weekday) date = date.subtract(Duration(days: weekday - i));
        if (i > weekday) date = date.add(Duration(days: i - weekday));
        await plugin.zonedSchedule(
          ++notificationId,
          note.title.replaceAll("\n", " "),
          null,
          tz.TZDateTime.from(date, tz.local),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          payload: note.id,
        );
        ids.add(notificationId);
      }
      await prefs.setInt("mind-me-notification-id", notificationId);
      return ids;
    } catch (e) {
      return null;
    }
  }

  Future remove(List<int> ids) async {
    for (var id in ids) await plugin.cancel(id);
  }

  Future clear() async {
    await plugin.cancelAll();
  }
}
