import 'package:get/get.dart';
import 'package:mind_me/src/utils.dart';
import 'navigation.service.dart';

class StartupService {
  final nav = Get.find<NavigationService>();
  Future start() async {
    await Future.delayed(Duration(milliseconds: 500));
    nav.pushReplacement(MindMePages.Home);
  }
}
