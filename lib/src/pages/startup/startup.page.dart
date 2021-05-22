import 'package:flutter/material.dart';

import '../../service/service.dart';
import '../../utils.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({Key? key}) : super(key: key);

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  void initState() {
    Get.find<StartupService>().start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
