import 'package:get/get.dart';

import 'service.dart';
import '../stores/config.store.dart';
import '../stores/notes.store.dart';
import '../utils.dart';

class StartupService {
  bool started = false;

  final nav = Get.find<NavigationService>();
  final auth = Get.find<AuthService>();
  final store = Get.find<NotesStore>();
  final config = Get.find<ConfigStore>();
  final notification = Get.find<NotificationService>();

  Future start() async {
    if (!started) {
      try {
        started = true;
        await auth.init();
        await config.init();
        await store.getNotes();
        await notification.init();
      } catch (e) {
        started = false;
      }
    }
    nav.pushAsFirst(MindMePages.Home);
  }
}
