
import 'package:flutter/material.dart';

import '../../../../../core/theming/my_colors.dart';


class SmallButton extends StatelessWidget {
  final bool isDone;
  final bool isError;

  const SmallButton(
      this.isDone, {
        super.key,
        required this.isError,
      });

  @override
  Widget build(BuildContext context) {
    final containerColor = getColor();
    final icon = getIcon();

    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: containerColor),
      child: Center(child: icon),
    );
  }

  Color getColor() {
    if (isError) {
      return Colors.red;
    } else if (isDone) {
      return Colors.green;
    } else {
      return MyColors.kPrimaryColor;
    }
  }

  Widget getIcon() {
    if (isError) {
      return const Icon(
        Icons.close,
        color: Colors.white,
      );
    } else if (isDone) {
      return const Icon(
        Icons.check,
        color: Colors.white,
      );
    } else {
      return const CircularProgressIndicator(
        color: Colors.white,
      );
    }
  }
}