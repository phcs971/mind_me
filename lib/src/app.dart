import 'dart:io';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'utils.dart';
import 'service/navigation.service.dart';

class MindMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log.d("<App> (Re)Build");
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: GetMaterialApp(
        title: 'Mind Me',
        translations: MindMeTexts(),
        initialRoute: MindMePages.Startup,
        onGenerateRoute: onGenerateRoute,
        navigatorKey: Get.find<NavigationService>().navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: MindMeTexts().keys.keys.map((k) => Locale(k)).toList(),
        theme: ThemeData(
          primaryColor: MindMeColors.yellow,
          accentColor: MindMeColors.orange,
          fontFamily: MindMeStyles.fontFamily,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: MindMeStyles.title,
          ),
        ),
        locale: Locale(Platform.localeName.split("_").first),
        fallbackLocale: Locale('en'),
      ),
    );
  }
}

extension CarbonBackButtonIcon on BackButtonIcon {
  // @override
  Widget build(BuildContext context) => Icon(CarbonIcons.chevron_left);
}
