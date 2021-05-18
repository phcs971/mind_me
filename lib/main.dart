import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/app.dart';
import 'src/singletons.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  initSingletons();
  runApp(MindMeApp());
}
