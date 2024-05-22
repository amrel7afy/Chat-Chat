import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalSpacer extends StatelessWidget {
   VerticalSpacer(this.verticalSpace, {super.key});

  double verticalSpace;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: verticalSpace.h);
  }
}

class HorizontalSpacer extends StatelessWidget {
   HorizontalSpacer(this.horizontalSpace, {super.key});

  double horizontalSpace;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: horizontalSpace.w);
  }
}
