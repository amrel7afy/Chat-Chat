import 'package:flutter/material.dart';

import 'information_view_widgets/information_view_body.dart';


class InformationView extends StatelessWidget {
  const InformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: InformationViewBody()),
    );
  }
}
