import 'package:flutter/material.dart';
import 'messaging_view_widgets/messaging_view_body.dart';

class MessagingView extends StatelessWidget {
  const MessagingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: MessagingViewBody()),
    );
  }
}
