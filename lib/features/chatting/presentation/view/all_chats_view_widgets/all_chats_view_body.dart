import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';


class AllChatsViewBody extends StatelessWidget {
  const AllChatsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kLeftHomeViewPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              ],
            ),
          ),
        ),
      ],
    );
  }
}
