import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:mind_me/src/service/service.dart';

import '../utils.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget> actions;
  final bool returnArrow;
  const AppBarWidget(
      {Key? key,
      required this.title,
      this.leading,
      this.actions = const [],
      this.returnArrow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<NavigationService>();
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      centerTitle: true,
      actions: actions,
      title: Text(title, style: MindMeStyles.title),
      backgroundColor: Colors.white,
      leading: leading != null
          ? leading
          : returnArrow
              ? IconButton(
                  icon: Icon(CarbonIcons.chevron_left),
                  onPressed: nav.pop,
                )
              : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
