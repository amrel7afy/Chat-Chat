
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/listen_to_messages_cubit/listen_to_messages_state.dart';

import '../../../../../core/theming/styles.dart';
import '../../view_model/listen_to_messages_cubit/listen_to_messages_cubit.dart';
import '../../view_model/unread_messages_count/unread_messages_count_cubit.dart';
import '../../view_model/unread_messages_count/unread_messages_count_state.dart';

class LastMessageTimeAndUnreadCount extends StatelessWidget {
   const LastMessageTimeAndUnreadCount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    log(context.read<ListenToMessagesCubit>().lastMessageDateTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //هنا استخدمت blocbuilder عشان ي update الlastMessageDateTime
        BlocBuilder<ListenToMessagesCubit, ListenToMessagesState>(
  builder: (context, state) {
    return Text(
          context.read<ListenToMessagesCubit>().lastMessageDateTime,
          style: MyTextStyles.font11Weight600.copyWith(color:Colors.black45),
        );
  },
),
         UnReadMessagesBloc(),

      ],
    );
  }
}

class UnReadMessagesBloc extends StatelessWidget {
  const UnReadMessagesBloc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnreadMessagesCountCubit, UnreadMessagesCountState>(
      builder: (context, state) {
        if(state is ExistsUnreadMessagesState){
          return buildUnReadMessageAvatar(state);}
        else{
          return const SizedBox(
            width: 1,height: 1,
          );
        }
      },
    );
  }



  CircleAvatar buildUnReadMessageAvatar(ExistsUnreadMessagesState state) {
    double radius;
    if(state.unreadCount>9){
      radius=10.0;
    }else{
      radius=8.0;
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: MyColors.kPrimaryColor,
      child: Text(
        state.unreadCount.toString(),
        style: MyTextStyles.font11Weight600.copyWith(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w900),
      ),
    );
  }
}