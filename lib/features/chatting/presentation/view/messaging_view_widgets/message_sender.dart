import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/di/locator.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/listen_to_messages_cubit/listen_to_messages_cubit.dart';

import '../../../../../core/theming/my_colors.dart';

class MessageSender extends StatelessWidget {
  const MessageSender({super.key});

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
        buildSenderIconButton(),
        const SizedBox()
      ],
    );
  }
  Widget buildSenderIconButton() {

      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
           /* if (locator<ListenToMessagesCubit>().messageController.text.isNotEmpty) {
              ChatCubit.getCubit(context).sendAMessage(
                  recieverId: widget.friendModel.userId,
                  message: messageController.text.trim());
              context.read<AddReceiverChatDataCubit>().updateUnreadMessagesCountOfReceiver(receiverId: widget.friendModel.userId, isOpened: false);
            }
            setState(() {
              messageController.clear();
            });
            if(ListenToMessagesCubit.getCubit(context).messages.isNotEmpty){
              _scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.bounceOut);
            }*/
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
