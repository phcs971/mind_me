import 'package:flutter/material.dart';

import '../utils.dart';

class ButtonWidget extends StatelessWidget {
  final Color color, textColor;
  final Color? borderColor, deactiveColor;
  final String text;
  final void Function() onPressed;
  final double? width;
  final bool active;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.active = true,
      this.width,
      this.deactiveColor,
      this.color = MindMeColors.successGreen,
      this.textColor = Colors.white,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: active ? onPressed : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) return deactiveColor ?? color;
          return color;
        }),
        padding: MaterialStateProperty.all(EdgeInsets.all(16)),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: (active ? borderColor : deactiveColor) ?? color, width: 2),
          ),
        ),
      ),
      child: Container(
        width: width,
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
          style: MindMeStyles.subtitle1.copyWith(color: textColor, height: 1),
        ),
      ),
    );
  }
}
