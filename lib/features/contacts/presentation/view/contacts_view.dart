import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/widgets/custom_app_bar.dart';

import 'contacts_view_widgets/contacts_view_body.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar:CustomAppBar(text: 'Select a contact'),
      body: SafeArea(child: ContactsViewBody()),
    );
  }
}

