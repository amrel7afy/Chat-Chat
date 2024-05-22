import'package:flutter/material.dart';
import 'constants.dart';
String removeSubString(String string, String subString) {
  String escapedSubstring = RegExp.escape(subString);
  RegExp pattern = RegExp(escapedSubstring);

  if (pattern.hasMatch(string)) {
    return string.replaceAll(pattern, '');
  } else {
    return string;
  }
}
double getHeight(context) {
  return MediaQuery.of(context).size.height;
}
double getWidth(context) {
  return MediaQuery.of(context).size.width;
}

void pushReplacementWithDelayed(context,widgetId) {
  Future.delayed( kNavigationDurationVal).then((value) {
    Navigator.pushReplacementNamed(context, widgetId);
  });
}
void navigateTo(context,widgetId,{arguments}) {
    Navigator.pushNamed(context, widgetId,arguments: arguments);

}


