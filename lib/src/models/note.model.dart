import 'dart:math';

import 'package:flutter/material.dart';

import 'package:validators/validators.dart';

import '../utils.dart';

class NoteDatabase {
  static const String table = "notes";
  static const String columnId = "Id";
  static const String columnIndex = "ListIndex";
  static const String columnTitle = "Title";
  static const String columnColor = "Color";
  static const String columnLock = "Lock";
  static const String columnLocalAuth = "LocalAuth";
  static const String columnPassCode = "PassCode";
  static const String columnNotify = "Notify";
  static const String columnRandomNotification = "RandomNotification";
  static const String columnTime = "Time";
  static const String columnDates = "Dates";
  static const String columnNotificationsIds = "NotificationsIds";
}

class NoteModel {
  final String id;

  int index = -1;

  String title = "";
  Color color = MindMeColors.yellow;

  bool lock = false, localAuth = false;
  String? passCode;

  bool notify = false, randomNotification = false;
  TimeOfDay time = TimeOfDay.now();
  final List<bool> dates = [false, false, false, false, false, false, false];
  List<int>? notificationIds;

  NoteModel() : id = DateTime.now().millisecondsSinceEpoch.toString();

  String get notificationText {
    if (notify) {
      String date;
      if (randomNotification)
        return MindMeTexts.notificationRandom.tr;
      else if (dates.every((i) => i))
        date = MindMeTexts.notificationEveryday.tr;
      else if (dates == [true, false, false, false, false, false, true])
        date = MindMeTexts.notificationWeekend.tr;
      else if (dates == [false, true, true, true, true, true, false])
        date = MindMeTexts.notificationWeekday.tr;
      else
        date = List<String>.generate(7, (i) => dates[i] ? datesString[i].tr : "")
            .where((i) => !isNull(i))
            .toList()
            .join("/");
      if (!isNull(date)) return "${time.format(Get.context!)} - $date";
    }
    return "";
  }

  resetNotification() {
    notify = false;
    randomNotification = false;
    resetSpecificNotification();
  }

  resetSpecificNotification() {
    time = TimeOfDay(hour: 0, minute: 0);
    for (var i = 0; i < dates.length; i++) dates[i] = false;
    notificationIds = null;
  }

  randomizeNotification() {
    final rand = Random();
    time = TimeOfDay(hour: rand.nextInt(13) + 9, minute: rand.nextInt(12) * 5);
    for (var i = 0; i < dates.length; i++) dates[i] = rand.nextBool();
    randomNotification = false;
  }

  resetLock() {
    lock = false;
    localAuth = false;
    resetPassCode();
  }

  resetPassCode() {
    passCode = null;
  }

  bool compareNotificationDate(NoteModel other) => other.dates == dates && time == other.time;

  @override
  String toString() {
    return """

${"-=" * 15}-
Lembrete $index -> $id
"$title"
Color: $color
${"-" * 31}
Lock: $lock
LocalAuth: $localAuth
PassCode: $passCode
${"-" * 31}
Notifitcation: $notify
AtRandom: $randomNotification
Time: ${time.format(Get.context!)}
Dates: ${List<String>.generate(7, (i) => dates[i] ? datesString[i].tr : "").where((i) => !isNull(i)).toList().join("/")}
${"-" * 31}
NotificationText: $notificationText
${"-" * 31}
NotificationsIds: $notificationIds
${"-=" * 15}-
    """;
  }

  Map<String, dynamic> toJson() => {
        NoteDatabase.columnId: id,
        NoteDatabase.columnIndex: index,
        NoteDatabase.columnTitle: title,
        NoteDatabase.columnColor: color.value,
        NoteDatabase.columnLock: lock ? 1 : 0,
        NoteDatabase.columnLocalAuth: localAuth ? 1 : 0,
        NoteDatabase.columnPassCode: passCode,
        NoteDatabase.columnNotify: notify ? 1 : 0,
        NoteDatabase.columnRandomNotification: randomNotification ? 1 : 0,
        NoteDatabase.columnTime: "${time.hour}:${time.minute}",
        NoteDatabase.columnDates: dates.map<String>((v) => v ? "1" : "0").join(),
        NoteDatabase.columnNotificationsIds: notificationIds?.join(";"),
      };

  NoteModel.fromJson(Map<String, dynamic> json)
      : id = json[NoteDatabase.columnId],
        index = json[NoteDatabase.columnIndex] ?? -1,
        title = json[NoteDatabase.columnTitle],
        color = Color(json[NoteDatabase.columnColor]),
        lock = json[NoteDatabase.columnLock] == 1,
        localAuth = json[NoteDatabase.columnLocalAuth] == 1,
        passCode = json[NoteDatabase.columnPassCode],
        notify = json[NoteDatabase.columnNotify] == 1,
        randomNotification = json[NoteDatabase.columnRandomNotification] == 1,
        notificationIds = (json[NoteDatabase.columnNotificationsIds] as String?)
                ?.split(";")
                .map<int>((v) => int.tryParse(v) ?? -1)
                .toList() ??
            [] {
    final _time = (json[NoteDatabase.columnTime] as String? ?? "").split(":");
    time = _time.length == 2
        ? TimeOfDay(hour: int.tryParse(_time[0]) ?? 0, minute: int.tryParse(_time[1]) ?? 0)
        : TimeOfDay.now();
    final _dates = (json[NoteDatabase.columnDates] as String? ?? "").split("");
    if (_dates.length == 7) {
      for (var i = 0; i < 7; i++) dates[i] = _dates[i] == "1";
    }
  }
}

const List<String> datesString = [
  MindMeTexts.daySun,
  MindMeTexts.dayMon,
  MindMeTexts.dayTue,
  MindMeTexts.dayWed,
  MindMeTexts.dayThu,
  MindMeTexts.dayFri,
  MindMeTexts.daySat
];
