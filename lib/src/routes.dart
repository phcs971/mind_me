import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'pages/startup/startup.page.dart';
import 'pages/config/config.page.dart';
import 'pages/home/home.page.dart';
import 'pages/note/note.page.dart';
import 'utils.dart';

class MindMePages {
  MindMePages._();

  static const Home = "/home";
  static const Config = "/config";
  static const Note = "/note";
  static const Startup = "/";
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Route<dynamic> page(Widget widget) =>
      MaterialPageRoute(builder: (_) => widget, settings: settings);

  log.i('<Router> Routing to ${settings.name}');

  switch (settings.name) {
    case MindMePages.Home:
      return page(HomePage());
    case MindMePages.Note:
      return page(NotePage());
    case MindMePages.Config:
      return page(ConfigPage());
    default:
      return page(StartupPage());
  }
}
