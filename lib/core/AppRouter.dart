
import 'dart:developer';
import 'package:flutter/material.dart';
import '../features/chatting/presentation/view/all_chats_view.dart';
import '../features/chatting/presentation/view/messaging_view.dart';
import '../features/information/presentation/view/information_view.dart';
import '../features/login/presentation/view/login_view.dart';
import '../features/login/presentation/view/otp_view.dart';
import '../features/onboarding/presentation/view/onboarding_view.dart';
import 'constants/constants.dart';
import 'helper/cache_helper.dart';




class AppRouter {
  static Future<String> getInitialRouteFromSharedPreferences() async {
    bool isSignedIn = await CacheHelper.getData(key: isSignedInKey) ?? false;
    log('$isSignedIn isSignedIn');
    bool isOnBoarded = await CacheHelper.getData(key: isOnBoardingKey) ?? false;
    log('$isOnBoarded isOnBoarded');
    if (isSignedIn) {
      return homeView; // User is logged in, navigate to chatPage
    } else if (isOnBoarded) {
      return loginView; // User hasn't logged in but completed onboarding
    } else {
      return onBoardingView; // User hasn't completed onboarding
    }
  }

  static const String homeView = '/homeView';
  static const String onBoardingView = '/';
  static const String loginView = '/LoginView';
  static const String informationView = '/informationView';
  static const String otpView = '/otpView';
  static const String messagingView = '/messagingView';

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeView:
        return MaterialPageRoute(
            builder: (context) =>  const AllChatsView());
      case otpView:
        return MaterialPageRoute(
            builder: (context) =>  const OTPView());
      case messagingView:
        return MaterialPageRoute(
            builder: (context) =>  const MessagingView());
      case informationView:
        return MaterialPageRoute(
            builder: (context) =>  const InformationView());
      case onBoardingView:
        log('hello');
        return MaterialPageRoute(
            builder: (context) =>  const OnBoardingView());
      case loginView:
        log('hello');
        return MaterialPageRoute(
            builder: (context) =>  const LoginView());
    }
    return null;
  }
}
