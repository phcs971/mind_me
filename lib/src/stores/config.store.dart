import 'dart:io';
import 'dart:ui';

import 'package:mind_me/src/service/service.dart';
import 'package:mind_me/src/stores/notes.store.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

part 'config.store.g.dart';

class ConfigStore = _ConfigStoreBase with _$ConfigStore;

abstract class _ConfigStoreBase with Store {
  @observable
  String locale = Platform.localeName.split("_").first;

  @observable
  bool sendNotifications = false;

  @action
  Future init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locale = prefs.getString("mind-me-locale") ?? Platform.localeName.split("_").first;
    Get.updateLocale(Locale(locale));
    sendNotifications = prefs.getBool("mind-me-notifications") ?? false;
  }

  @action
  Future<void> setLocale(String _locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locale = _locale;
    Get.updateLocale(Locale(_locale));
    await prefs.setString("mind-me-locale", locale);
  }

  @action
  Future<void> setSendNotifications(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sendNotifications = value;
    await prefs.setBool("mind-me-notifications", value);
    if (sendNotifications)
      Get.find<NotesStore>().setAllNotifications();
    else
      Get.find<NotificationService>().clear();
  }
}
