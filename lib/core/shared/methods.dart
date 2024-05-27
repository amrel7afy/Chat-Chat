import 'dart:convert';
import 'dart:developer';

import '../constants/constants.dart';
import '../helper/cache_helper.dart';

Future saveUserToSP(userModel) async {
  try {
    String userJson = jsonEncode(userModel.toJson());
    await CacheHelper.saveData(
      key: userModelKey,
      value: userJson,
    );
  } catch (e) {
    log(e.toString());

  }
}