part of '../utils.dart';

extension CarbonBackButtonIcon on BackButtonIcon {
  // @override
  Widget build(BuildContext context) => Icon(CarbonIcons.chevron_left);
}

extension WidgetExtension on Diagnosticable {
  NavigationService get nav => Modular.get();
}
