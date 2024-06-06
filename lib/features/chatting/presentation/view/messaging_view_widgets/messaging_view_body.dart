import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/shared/user_model.dart';
import 'package:new_chat_with_me/core/widgets/custom_error_message.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view/messaging_view_widgets/success_body.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/add_reciever_chat_data_cubit/add_reciever_chat_data_cubit.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/listen_to_messages_cubit/listen_to_messages_cubit.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/listen_to_messages_cubit/listen_to_messages_state.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/loading_indicator.dart';
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
    super.initState();
    context.read<ListenToMessagesCubit>().listenToMessages(receiverId: widget.friendModel.userId);
    context.read<AddReceiverChatDataCubit>().addReceiverChatData(widget.friendModel, );
  }

/*  @override
  void dispose() {
    context.read<ListenToMessagesCubit>().close();
    context.read<AddReceiverChatDataCubit>().close();
    super.dispose();
  }*/
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: kLeftHomeViewPadding, top: 5),
            child: BlocBuilder<ListenToMessagesCubit, ListenToMessagesState>(
              builder: (context, state) {
                if (state is ListenToMessagesLoadingState) {
                  return const CustomLoadingIndicator();
                } else if (state is ListenToMessagesSuccessState) {
                  return SuccessBody(state: state, userId: widget.friendModel.userId);
                } else {
                  return const CustomErrorMessage(errorMessage: 'Send message now!');
                }
              },
            ),
          ),
        ),
        MessageSender(friendModel: widget.friendModel),
      ],
    );
  }
}
