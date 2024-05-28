import 'dart:developer';

import '../../../../../core/shared/chat_model.dart';

sealed class ChattingState {}

final class ChattingInitial extends ChattingState {}

final class ChattingLoading extends ChattingState {}

final class ChattingNoChats extends ChattingState {}

final class ChattingSuccess extends ChattingState {
  final List<ChatModel> chats;

  ChattingSuccess(this.chats);
}

final class ChattingFailure extends ChattingState {
  final String error;

  ChattingFailure(this.error) {
    log(error.toString());
  }
}
