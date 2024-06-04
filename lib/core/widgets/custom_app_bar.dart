import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';
import 'package:new_chat_with_me/core/theming/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final List<Widget>?actions;
  const CustomAppBar({super.key, required this.text,  this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: MyTextStyles.font23Weight700.copyWith(color: MyColors.kPrimaryColor),
      ),
      automaticallyImplyLeading: false,
      actions:actions?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
