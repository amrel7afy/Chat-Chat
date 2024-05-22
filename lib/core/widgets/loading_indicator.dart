import 'package:flutter/material.dart';

import '../theming/my_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.kPrimaryColor,
      ),
    );
  }
}
