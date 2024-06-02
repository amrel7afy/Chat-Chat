import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/shared/chat_model.dart';

class ChatSuccessBody extends StatelessWidget {
  final List<ChatModel> chats;
  const ChatSuccessBody({
    super.key, required this.chats,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) => MultiBlocProvider(
        providers:  [
          //   BlocProvider(create: (context) => ListenToMessagesCubit()),
          // BlocProvider(create: (context) => UnreadMessagesCountCubit()),
        ],
        child: InkWell(
            onTap: () {
              /*Navigator.pushNamed(context, messagingPage,
                  arguments: context.read<ChatCubit>().users[index]);*/
            },
            child:
            Text(chats[index].phoneNumber)
          //    ChatItemBuilder(chatModel: chats[index])
        ),
      ),
    );
  }
}