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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //final AddReceiverChatDataCubit addReceiverChatDataCubit; // Add this field

  ListenToMessagesCubit(this.sharedRepository,
     // this.addReceiverChatDataCubit
      )
      : super(ListenToMessagesInitial());

  List<MessageModel> messages = [];
  String lastMessageDateTime = '';
  final scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  bool isReceiverDataAdded = false; // Track if receiver data is added

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
          if (messages.isEmpty) {
            emit(NoMessagesState());
          } else {
            emit(ListenToMessagesSuccessState(messages));
          }
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
      lastMessageDateTime =
          DateFormat('h:mm a').format(dateTime); // 'a' denotes AM/PM
      log(lastMessageDateTime);
    } else {
      log("No messages available.");
    }
  }

  sendMessage({
    required String receiverId,
  }) async {
    log(messageController.text.trim());
    if (messageController.text.trim().isEmpty) return;

    MessageModel messageModel = MessageModel(
      message: messageController.text.trim(),
      id: receiverId,
      dateTime: DateTime.now().toString(),
    );

    CollectionReference userMessagesReference = locator<FirebaseFirestore>()
        .collection(kUserCollection)
        .doc(sharedRepository.userModel.userId)
        .collection(kChatsCollection)
        .doc(receiverId)
        .collection(kMessagesCollection);

    CollectionReference receiverMessagesReference = locator<FirebaseFirestore>()
        .collection(kUserCollection)
        .doc(receiverId)
        .collection(kChatsCollection)
        .doc(sharedRepository.userModel.userId)
        .collection(kMessagesCollection);

    await userMessagesReference.add(messageModel.toJson()).then((value) async {
      receiverMessagesReference.add(messageModel.toJson());
      log('sendMessage: ${messageController.text.trim()}');
      messageController.clear();

      // Add receiver data after sending the first message
      if (!isReceiverDataAdded) {
      //  await addReceiverChatDataCubit.addReceiverChatData(sharedRepository.userModel);
        isReceiverDataAdded = true; // Mark as added
      }
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
