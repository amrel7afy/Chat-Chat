import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


import '../../../../../core/constants/constants.dart';
import '../../../../../core/di/locator.dart';
import '../../../../../core/shared/shared_repo.dart';
import '../../../data/model/message_model.dart';
import 'listen_to_messages_state.dart';


class ListenToMessagesCubit extends Cubit<ListenToMessagesState> {
  final SharedRepository sharedRepository;
  ListenToMessagesCubit(this.sharedRepository) : super(ListenToMessagesInitial());

  static ListenToMessagesCubit getCubit(BuildContext context) => BlocProvider.of(context);
  List<MessageModel> messages = [];
    String lastMessageDateTime='';
  final scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  listenToMessages({required String receiverId}) async {
    emit(ListenToMessagesLoadingState());

    try {
      locator<FirebaseFirestore>()
          .collection(kUserCollection)
          .doc(sharedRepository.userModel.userId)
          .collection(kChatsCollection)
          .doc(receiverId)
          .collection(kMessagesCollection)
          .orderBy('dateTime', descending: true)
          .snapshots()
          .listen((event) {
        messages = event.docs
            .map((message) => MessageModel.fromJson(message.data()))
            .toList();
        getTheTimeOfLastMessage();

        emit(ListenToMessagesSuccessState(messages));
        if (messages.isEmpty) {
          emit(NoListenMessagesState());
        }
      }
      );
      log('returned messages: ${  messages.length.toString()}');
      return messages;
    } catch (e) {
      log('getAndListenToMessages: $e');
      emit(ListenToMessagesFailureState(e.toString()));
    }
  }

  void getTheTimeOfLastMessage() {
    if (messages.isNotEmpty) {
      DateTime dateTime = DateTime.parse(messages[0].dateTime);
      // Formatting the DateTime to include AM/PM
      lastMessageDateTime = DateFormat('h:mm a').format(dateTime); // 'a' denotes AM/PM
      log(lastMessageDateTime);
    } else {
      log("No messages available.");
    }
  }
}
