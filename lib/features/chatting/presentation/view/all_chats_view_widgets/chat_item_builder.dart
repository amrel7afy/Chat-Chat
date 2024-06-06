import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';

import '../../../../../core/shared/chat_model.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../contacts/presentation/view/contacts_view_widgets/no_profile_image_avatar.dart';
import '../../view_model/listen_to_messages_cubit/listen_to_messages_cubit.dart';
import '../../view_model/listen_to_messages_cubit/listen_to_messages_state.dart';
import '../../view_model/unread_messages_count/unread_messages_count_cubit.dart';
import 'last_message_time_and_unread_count.dart';

class ChatItemBuilder extends StatefulWidget {
  final ChatModel chatModel;

  const ChatItemBuilder({super.key, required this.chatModel});

  @override
  State<ChatItemBuilder> createState() => _ChatItemBuilderState();
}

class _ChatItemBuilderState extends State<ChatItemBuilder> {
  final String defaultProfileNetworkImage =
      'https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.nicepng.com%2Fpng%2Fdetail%2F933-9332131_profile-picture-default-png.png&tbnid=bLv2FccUvqriEM&vet=10CAYQxiAoB2oXChMI-OCPhr3cgwMVAAAAAB0AAAAAEAc..i&imgrefurl=https%3A%2F%2Fwww.nicepng.com%2Fourpic%2Fu2y3a9e6t4o0a9w7_profile-picture-default-png%2F&docid=-E5pvHnffveX2M&w=820&h=719&itg=1&q=profile%20image%20png&ved=0CAYQxiAoB2oXChMI-OCPhr3cgwMVAAAAAB0AAAAAEAc';


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
          leading: widget.chatModel.profilePic.isEmpty
              ? const NoChatProfileImageAvatar()
              : CircleAvatar(
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


