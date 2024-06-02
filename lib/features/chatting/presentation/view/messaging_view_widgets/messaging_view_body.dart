import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/shared/user_model.dart';
import 'package:new_chat_with_me/core/widgets/custom_error_message.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/listen_to_messages_cubit/listen_to_messages_cubit.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/listen_to_messages_cubit/listen_to_messages_state.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/loading_indicator.dart';
import 'chat_bubbles.dart';
import 'message_sender.dart';

class MessagingViewBody extends StatefulWidget {
final UserModel friendModel;
  const MessagingViewBody({super.key, required this.friendModel});

  @override
  State<MessagingViewBody> createState() => _MessagingViewBodyState();
}

class _MessagingViewBodyState extends State<MessagingViewBody> {
  @override
  void initState() {
    context.read<ListenToMessagesCubit>().listenToMessages(receiverId: widget.friendModel.userId);
        super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: kLeftHomeViewPadding, top: 5),
            child: Column(
              children: [
                BlocBuilder<ListenToMessagesCubit, ListenToMessagesState>(
                  builder: (context, state) {
                    if (state is ListenToMessagesLoadingState) {
                      return const CustomLoadingIndicator();
                    } else if (state is NoListenMessagesState) {
                      return const CustomErrorMessage(errorMessage: 'Send message now!');
                    } else if (state is ListenToMessagesSuccessState) {
                      return Expanded(
                        child: ListView.builder(
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
                        ),
                      );
                    } else {
                      return const CustomErrorMessage(errorMessage: 'Something went wrong!');
                    }
                  },
                ),
                const MessageSender(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
