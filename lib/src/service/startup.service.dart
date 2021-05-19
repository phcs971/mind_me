import 'package:get/get.dart';
import 'package:mind_me/src/stores/notes.store.dart';
import 'package:mind_me/src/utils.dart';
import 'navigation.service.dart';

class StartupService {
  final nav = Get.find<NavigationService>();
  final store = Get.find<NotesStore>();
  Future start() async {
    await Future.delayed(Duration(milliseconds: 500));
    await store.getNotes();
    nav.pushReplacement(MindMePages.Home);
  }
}
