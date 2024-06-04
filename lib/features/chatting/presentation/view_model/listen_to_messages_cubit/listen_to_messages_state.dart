import 'dart:developer';

import '../../../data/model/message_model.dart';

abstract class ListenToMessagesState {}

class ListenToMessagesInitial extends ListenToMessagesState {}

class ListenToMessagesLoadingState extends ListenToMessagesState {}

class ListenToMessagesSuccessState extends ListenToMessagesState {
  List<MessageModel> messages;

  ListenToMessagesSuccessState(this.messages);
}

class ListenToMessagesFailureState extends ListenToMessagesState {
  String error;

  ListenToMessagesFailureState(this.error);
}class SendMessageFailureState extends ListenToMessagesState {
  String error;

  SendMessageFailureState(this.error){
    log(error.toString());
  }
}
class NoListenMessagesState extends ListenToMessagesState{}
