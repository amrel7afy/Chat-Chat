import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/shared/shared_repo.dart';
import 'package:new_chat_with_me/core/shared/user_model.dart';

import '../../../../../core/AppRouter.dart';
import '../../../../../core/di/locator.dart';
import '../../view_model/listen_to_messages_cubit/listen_to_messages_cubit.dart';
import '../../view_model/unread_messages_count/unread_messages_count_cubit.dart';
import 'chat_item_builder.dart';

class ChatSuccessBody extends StatelessWidget {
  final List<UserModel> chats;

  const ChatSuccessBody({
    super.key, required this.chats,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) =>
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRouter.messagingView,
                    arguments: locator<SharedRepository>().userChats[index]
                );
              },
              child:
              // Text(chats[index].phoneNumber)
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => locator<ListenToMessagesCubit>(),
                  ),  BlocProvider(
                    create: (context) => locator<UnreadMessagesCountCubit>(),
                  ),


                ],
                child: ChatItemBuilder(chatModel: chats[index]),
              )
          ),
    );
  }
}