

import 'dart:developer';


import 'package:flutter/material.dart';

import '../features/chatting/presentation/view/all_chats_view.dart';
import '../features/chatting/presentation/view/messaging_view.dart';
import '../features/information/presentation/view/information_view.dart';
import '../features/login/presentation/view/login_view.dart';
import '../features/login/presentation/view/otp_view.dart';
import '../features/onboarding/presentation/view/onboarding_view.dart';




class AppRouter {

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
