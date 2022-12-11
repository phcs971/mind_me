import 'package:get/get.dart';

import 'utils.dart';
import 'stores/config.store.dart';
import 'stores/notes.store.dart';
import 'service/service.dart';

void initSingletons() {
  log.v("<Singletons> Register Navigation Service");
  Get.put(NavigationService());
  log.v("<Singletons> Register Config Store");
  Get.put(ConfigStore());
  log.v("<Singletons> Register Notes Store");
  Get.put(NotesStore());
  log.v("<Singletons> Register Auth Service");
  Get.put(AuthService());
  log.v("<Singletons> Register Notification Service");
  Get.put(NotificationService());
  log.v("<Singletons> Register Startup Service");
  Get.put(StartupService());
}
