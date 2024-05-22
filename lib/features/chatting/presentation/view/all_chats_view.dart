import 'package:flutter/material.dart';

import 'all_chats_view_widgets/all_chats_view_body.dart';

class AllChatsView extends StatelessWidget {
  const AllChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: AllChatsViewBody()),
    );
  }
}
