import 'package:flutter/material.dart';

import 'otp_view_widgets/otp_view_body.dart';


class OTPView extends StatelessWidget {
  final String verificationId;
  const OTPView({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: OTPViewBody(verificationId:verificationId)),
    );
  }
}
