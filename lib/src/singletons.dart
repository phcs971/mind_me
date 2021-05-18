import 'package:get/get.dart';

import 'utils.dart';
import 'stores/notes.store.dart';
import 'service/service.dart';

void initSingletons() {
  log.v("<Singletons> Register Navigation Service");
  Get.put(NavigationService());
  log.v("<Singletons> Register Startup Service");
  Get.put(StartupService());
  log.v("<Singletons> Register Notes Store");
  Get.put(NotesStore());
}
