import 'package:flutter/material.dart';

import '../theming/my_colors.dart';


ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(BuildContext context,
    String e ){

  return   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      content: Container(
        alignment: Alignment.center,

      decoration: BoxDecoration(
        color: MyColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Text(e,),),
    ),);
}