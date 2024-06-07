import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/shared/user_model.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';

import '../../../../../core/theming/styles.dart';
import '../../view_model/listen_to_messages_cubit/listen_to_messages_cubit.dart';
import '../../view_model/listen_to_messages_cubit/listen_to_messages_state.dart';
import '../../view_model/unread_messages_count/unread_messages_count_cubit.dart';
import 'last_message_time_and_unread_count.dart';

class ChatItemBuilder extends StatefulWidget {
  final UserModel chatModel;

  const ChatItemBuilder({super.key, required this.chatModel});

  @override
  State<ChatItemBuilder> createState() => _ChatItemBuilderState();
}

class _ChatItemBuilderState extends State<ChatItemBuilder> {


  @override
  void initState() {

    context.read<ListenToMessagesCubit>().listenToMessages(
        receiverId: '+2${widget.chatModel.phoneNumber}');
    context.read<UnreadMessagesCountCubit>().listenToUnreadMessagesCount(receiverId: '+2${widget.chatModel.phoneNumber}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListenToMessagesCubit, ListenToMessagesState>(
      builder: (context, state) {
        if (state is ListenToMessagesSuccessState) {}
        return ListTile(
          title: nameAndLastMessage(state),
          leading:CircleAvatar(
                  radius: 25,
                  backgroundColor: MyColors.kPrimaryColor,
                  backgroundImage: NetworkImage(widget.chatModel.profilePic)),
          trailing: const LastMessageTimeAndUnreadCount(),
        );
      },
    );
  }

  Column nameAndLastMessage(ListenToMessagesState state) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chatModel.name,
              style: MyTextStyles.font14Weight700
                  .copyWith(color: MyColors.kPrimaryColor),
            ),
            if (state is ListenToMessagesSuccessState)
              Text(
                state.messages[0].message,
                overflow: TextOverflow.ellipsis,
                style: MyTextStyles.font11Weight600.copyWith(color: Colors.black45),
              )
          ],
        );
  }
}


