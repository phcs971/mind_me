part of '../utils.dart';

class MindMeTheme {
  MindMeTheme._();

  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme(
      background: MindMeColors.white,
      brightness: Brightness.light,
      error: MindMeColors.red,
      onBackground: MindMeColors.black,
      onError: MindMeColors.white,
      onPrimary: MindMeColors.black,
      onSecondary: MindMeColors.black,
      onSurface: MindMeColors.black,
      primary: MindMeColors.yellow,
      primaryVariant: MindMeColors.darkYellow,
      secondary: MindMeColors.orange,
      secondaryVariant: MindMeColors.orange,
      surface: MindMeColors.white,
    ),
  );
}
