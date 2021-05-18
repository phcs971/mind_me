import 'package:flutter/material.dart';

import '../../utils.dart';
import '../../widgets/app_bar.widget.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: MindMeTexts.settingsPage.tr, returnArrow: true),
    );
  }
}
