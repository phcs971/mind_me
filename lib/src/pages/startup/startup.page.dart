import 'package:flutter/material.dart';

import '../../service/service.dart';
import '../../utils.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => Get.find<StartupService>().start());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(MindMeImages.splashScreen),
            ),
          ),
          Positioned(
            bottom: 32 + Get.mediaQuery.padding.bottom,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(MindMeColors.yellow),
            ),
          ),
        ],
      ),
    );
  }
}
