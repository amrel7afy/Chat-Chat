import 'package:flutter/material.dart';

import 'otp_view_widgets/otp_view_body.dart';


class OTPView extends StatelessWidget {
  const OTPView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: OTPViewBody()),
    );
  }
}
