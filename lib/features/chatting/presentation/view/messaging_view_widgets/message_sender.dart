import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/di/locator.dart';
import 'package:new_chat_with_me/core/shared/user_model.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/listen_to_messages_cubit/listen_to_messages_cubit.dart';

import '../../../../../core/theming/my_colors.dart';

class MessageSender extends StatelessWidget {
  final UserModel friendModel;
  const MessageSender({super.key, required this.friendModel});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 3, 10),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              controller: locator<ListenToMessagesCubit>().messageController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              cursorHeight: 23,
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle:
                TextStyle(color: Colors.grey[400], fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        buildSenderIconButton(context),
        const SizedBox()
      ],
    );
  }
  Widget buildSenderIconButton(BuildContext context) {

      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: ()async {

             await context.read<ListenToMessagesCubit>().sendMessage(
                  recieverId: friendModel.userId,);
             // context.read<AddReceiverChatDataCubit>().updateUnreadMessagesCountOfReceiver(receiverId: widget.friendModel.userId, isOpened: false);

              context.read<ListenToMessagesCubit>(). messageController.clear();

            if(ListenToMessagesCubit.getCubit(context).messages.isNotEmpty){
              locator<ListenToMessagesCubit>().scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.bounceOut);
            }
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
}
