import 'dart:async';
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
  late StreamSubscription _subscription;
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  ListenToMessagesCubit(this.sharedRepository)
      : super(ListenToMessagesInitial());


  List<MessageModel> messages = [];
  String lastMessageDateTime = '';
  final scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  listenToMessages({required String receiverId}) async {
    emit(ListenToMessagesLoadingState());
    try {
      _subscription = locator<FirebaseFirestore>()
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

        if (!isClosed) {
          emit(ListenToMessagesSuccessState(messages));
        }

        if (messages.isEmpty && !isClosed) {
          emit(NoListenMessagesState());
        }
      });
      log('returned messages: ${messages.length.toString()}');
      return messages;
    } catch (e) {
      log('getAndListenToMessages: $e');
      if (!isClosed) {
        emit(ListenToMessagesFailureState(e.toString()));
      }
    }
  }

  void getTheTimeOfLastMessage() {
    if (messages.isNotEmpty) {
      DateTime dateTime = DateTime.parse(messages[0].dateTime);
      // Formatting the DateTime to include AM/PM
      lastMessageDateTime =
          DateFormat('h:mm a').format(dateTime); // 'a' denotes AM/PM
      log(lastMessageDateTime);
    } else {
      log("No messages available.");
    }
  }

  sendMessage ({
    required String recieverId,
  }) async {
    log(messageController.text.trim());
    MessageModel messageModel = MessageModel(
        message: messageController.text.trim(),
        id: recieverId,
        dateTime: DateTime.now().toString());
    //log('sharedRepository.userModel.userId${sharedRepository.userModel.userId}');
    //put message in my chat messages collection and my friend messages collection.
    CollectionReference userMessagesReference = locator<FirebaseFirestore>()
        .collection(kUserCollection)
        .doc(sharedRepository.userModel.userId)
        .collection(kChatsCollection)
        .doc(recieverId)
        .collection(kMessagesCollection);

    CollectionReference receiverMessagesReference = locator<FirebaseFirestore>()
        .collection(kUserCollection)
        .doc(recieverId)
        .collection(kChatsCollection)
        .doc(sharedRepository.userModel.userId)
        .collection(kMessagesCollection);

    await userMessagesReference.add(messageModel.toJson()).then((value) {
      receiverMessagesReference.add(messageModel.toJson());
      log('sendMessage: ${messageController.text.trim()}');
      // emit(ChatSendMessageSuccessState());
    }).catchError((e) {
      log('sendMessage: $e');
      if (!isClosed) {
        emit(SendMessageFailureState(e.toString()));
      }
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
