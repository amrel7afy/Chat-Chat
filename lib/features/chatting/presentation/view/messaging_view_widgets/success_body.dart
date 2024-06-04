import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/listen_to_messages_cubit/listen_to_messages_cubit.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/listen_to_messages_cubit/listen_to_messages_state.dart';
import 'chat_bubbles.dart';
import 'messaging_view_body.dart';


class SuccessBody extends StatelessWidget {
  final ListenToMessagesSuccessState state;
  const SuccessBody({
    super.key,
    required this.widget, required this.state
  });

  final MessagingViewBody widget;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: context.read<ListenToMessagesCubit>().scrollController, // You need to provide your controller here
      reverse: true,
      itemBuilder: (context, index) {
        final message = state.messages[index];
        final isMyMessage = message.id == widget.friendModel.userId;
        return isMyMessage
            ? MyChatBubble(messageModel: message)
            : OtherChatBubble(messageModel: message);
      },
      itemCount: state.messages.length,
    );
  }
}