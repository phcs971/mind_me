import 'package:flutter/material.dart';
import 'package:mind_me/src/service/service.dart';

import '../utils.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  const ConfirmDialog({Key? key, required this.title, this.subtitle}) : super(key: key);

  Future<bool> show() async {
    final result = await showDialog<bool>(context: Get.context!, builder: build);
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<NavigationService>();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      title: Text(title, style: MindMeStyles.subtitle1),
      content: subtitle != null ? Text(subtitle!, style: MindMeStyles.body2) : null,
      titlePadding: EdgeInsets.fromLTRB(24, 16, 24, 0),
      contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 0),
      actionsPadding: EdgeInsets.fromLTRB(24, 0, 16, 0),
      actions: [
        TextButton(
          child: Text(
            MindMeTexts.cancel.tr.toUpperCase(),
            style: MindMeStyles.button1.copyWith(fontWeight: FontWeight.w400, color: Colors.red),
          ),
          onPressed: () => nav.pop(false),
        ),
        TextButton(
          child: Text(
            MindMeTexts.ok.tr.toUpperCase(),
            style: MindMeStyles.button1.copyWith(fontWeight: FontWeight.w400, color: Colors.blue),
          ),
          onPressed: () => nav.pop(true),
        ),
      ],
    );
  }
}
