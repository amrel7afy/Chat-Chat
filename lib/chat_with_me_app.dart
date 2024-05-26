import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';

import 'core/AppRouter.dart';

class ChatWithMeApp extends StatelessWidget {
  const ChatWithMeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375,812),
      child: MaterialApp(
        initialRoute: AppRouter.onBoardingView,
        onGenerateRoute: AppRouter().generateRoute,
        theme: ThemeData(
          scaffoldBackgroundColor: MyColors.kGifBackGroundColor
        ),

      ),
    );
  }
}
