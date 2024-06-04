import 'dart:developer';

import '../../../../../core/shared/chat_model.dart';

sealed class ListenToAllChatsState {}

final class ListenToAllChatsInitial extends ListenToAllChatsState {}

final class ListenToAllChatsLoading extends ListenToAllChatsState {}

final class ListenToAllChatsNoChats extends ListenToAllChatsState {}

final class ListenToAllChatsSuccess extends ListenToAllChatsState {
  final List<ChatModel> chats;

  ListenToAllChatsSuccess(this.chats);
}

final class ListenToAllChatsFailure extends ListenToAllChatsState {
  final String error;

  ListenToAllChatsFailure(this.error) {
    log(error.toString());
  }
}
