import 'dart:convert';
import 'dart:developer';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/shared/shared_repo.dart';
import 'chat_with_me_app.dart';
import 'core/AppRouter.dart';
import 'core/constants/bloc_observer.dart';
import 'core/constants/constants.dart';
import 'core/di/locator.dart';
import 'core/helper/cache_helper.dart';
import 'core/shared/user_model.dart';
import 'core/theming/my_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await _initializeFirebase();
  setupLocator();
  _setSystemUIOverlayStyle();
  await getUserFromCache();
  final String initialRoute = await AppRouter.getInitialRouteFromSharedPreferences();
  runApp( ChatWithMeApp(initialRoute: initialRoute));
}



Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaEnterpriseProvider('recaptcha-v3-site-key'),
      androidProvider: AndroidProvider.debug,
    );
  } catch (e) {
    log('Error initializing Firebase: $e');
  }
}

void _setSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: MyColors.kGifBackGroundColor),
  );
}

Future getUserFromCache() async {
  try {
    String data = await CacheHelper.getData(key: userModelKey);
    locator<SharedRepository>().userModel = UserModel.fromJson(jsonDecode(data));
    log('getUserFromCache${locator<SharedRepository>().userModel.userId}');
  } catch (e) {
     log('No user data in cache.');
  }
}



