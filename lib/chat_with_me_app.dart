import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';

import 'core/AppRouter.dart';

class ChatWithMeApp extends StatelessWidget {
  final String initialRoute;
  const ChatWithMeApp({super.key, required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375,812),
      child: MaterialApp(
        initialRoute:AppRouter.informationView,
        //initialRoute: initialRoute,
        onGenerateRoute: AppRouter().generateRoute,
        theme: ThemeData(
          scaffoldBackgroundColor: MyColors.kGifBackGroundColor
        ),

      ),
    );
  }
}
