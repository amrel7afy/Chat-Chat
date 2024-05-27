import 'package:flutter/material.dart';
import 'package:new_chat_with_me/features/information/presentation/view/information_view_widgets/select_image_avatar_consumer.dart';

import '../../../../../core/constants/constants.dart';


class InformationViewBody extends StatelessWidget {
  const InformationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kLeftHomeViewPadding,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SelectImageAvatarConsumer()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
