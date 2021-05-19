import 'package:flutter/material.dart';

import 'package:validators/validators.dart';

import '../utils.dart';

class NoteModel {
  final String id;
  String title = "";
  Color color = MindMeColors.yellow;

  bool lock = false, localAuth = false;
  String? passCode;

  bool notify = false, randomNotification = false;
  TimeOfDay time = TimeOfDay.now();
  final List<bool> dates = [false, false, false, false, false, false, false];

  NoteModel() : id = DateTime.now().millisecondsSinceEpoch.toString();

  String get notificationText {
    if (notify) {
      String date;
      if (randomNotification)
        return MindMeTexts.notificationRandom.tr;
      else if (dates.every((i) => i))
        date = MindMeTexts.notificationEveryday.tr;
      else if (dates[0] && dates[6])
        date = MindMeTexts.notificationWeekend.tr;
      else if (dates.sublist(1, 6).every((i) => i))
        date = MindMeTexts.notificationWeekday.tr;
      else
        date = List<String>.generate(7, (i) => dates[i] ? datesString[i].tr : "")
            .where((i) => !isNull(i))
            .toList()
            .join("/");
      // if (selectedDates.isNotEmpty)
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
  }

  resetLock() {
    lock = false;
    localAuth = false;
    resetPassCode();
  }

  resetPassCode() {
    passCode = null;
  }

  @override
  String toString() {
    return """

${"-=" * 15}-
Lembrete -> $id
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
${"-=" * 15}-
    """;
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
