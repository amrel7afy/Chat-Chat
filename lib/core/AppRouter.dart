import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/di/locator.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/chatting_cubit/chatting_cubit.dart';
import 'package:new_chat_with_me/features/information/presentation/view_model/information_cubit.dart';
import 'package:new_chat_with_me/features/login/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:new_chat_with_me/features/login/presentation/view_model/otp_cubit/otp_cubit.dart';
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
  static const String profileView = '/profileView';

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeView:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => locator<ChattingCubit>(),
                child: const AllChatsView()));

      case otpView:
        log('otpView');
        final String verificationId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => locator<OTPCubit>(),
                  child: OTPView(verificationId: verificationId),
                ));
      case messagingView:
        log('messagingView');
        return MaterialPageRoute(builder: (context) => const MessagingView());
      case informationView:
        log('informationView');
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => locator<InformationCubit>(),
                child: const InformationView()));
      case onBoardingView:
        log('onBoardingView');
        return MaterialPageRoute(builder: (context) => const OnBoardingView());
      case loginView:
        log('loginView');
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => locator<LoginCubit>(),
                child: const LoginView()));
    }
    return null;
  }
}
