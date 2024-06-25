import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/shared/user_model.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/listen_to_messages_cubit/listen_to_messages_cubit.dart';
import '../../../../../core/theming/my_colors.dart';

class MessageSender extends StatelessWidget {
  final UserModel friendModel;
  const MessageSender({super.key, required this.friendModel});

  @override
  Widget build(BuildContext context) {
    log(context.read<ListenToMessagesCubit>().messageController.text.trim());

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 3, 10),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              controller: context.read<ListenToMessagesCubit>().messageController,

              keyboardType: TextInputType.multiline,
              maxLines: null,
              cursorHeight: 23,
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        buildSenderIconButton(context,),
        const SizedBox(),
      ],
    );
  }

  Widget buildSenderIconButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: ()  {
           context.read<ListenToMessagesCubit>().sendMessage(
            receiverId: friendModel.userId,
          );

          checkAndAnimate(context);

          // Clear the message controller after sending the message
          context.read<ListenToMessagesCubit>().messageController.clear();
        },
        child: const CircleAvatar(
          radius: 23,
          child: Icon(
            Icons.send,
            color: MyColors.kPrimaryColor,
          ),
        ),
      ),
    );
  }

  void checkAndAnimate(BuildContext context) {
    if (context.read<ListenToMessagesCubit>().messages.isNotEmpty) {
      context.read<ListenToMessagesCubit>().scrollController.animateTo(0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.bounceOut);
    }
  }
}
