import 'package:flutter_modular/flutter_modular.dart';
import 'package:mind_me/app/pages/startup_page.dart';

import 'modules/home/home_module.dart';
import 'utils.dart';

bool _routes(String name, [arguments]) {
  return ["/home/", "/"].contains(name);
}

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => NavigationService(homePage: '/home/', checkIsRouteRoot: _routes),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const StartupPage()),
    ModuleRoute("/home", module: HomeModule()),
  ];
}
