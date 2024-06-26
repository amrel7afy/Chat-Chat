import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/di/locator.dart';
import '../../../../../core/shared/shared_repo.dart';
import 'unread_messages_count_state.dart';

class UnreadMessagesCountCubit extends Cubit<UnreadMessagesCountState> {
  final SharedRepository sharedRepository;

  UnreadMessagesCountCubit(this.sharedRepository)
      : super(UnreadMessagesCountInitial());

  listenToUnreadMessagesCount({required String receiverId}) {
    DocumentReference receiverDocument = locator<FirebaseFirestore>()
        .collection(kUserCollection)
        .doc(sharedRepository.userModel.userId)
        .collection(kChatsCollection)
        .doc(receiverId);
    receiverDocument.snapshots().listen(
      (snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          final unreadCount = data['unreadMessagesCount'] ?? 0;
          if (unreadCount != 0) {
            emit(ExistsUnreadMessagesState(unreadCount as int));
          } else {
            emit(NotExistsUnreadMessagesState());
          }
        }
      },
      onError: (error) {
        emit(UnreadMessagesErrorState(error.toString()));
      },
      onDone: () {},
    );
  }

  updateUnreadMessagesCountOfReceiver(
      {required String receiverId, required bool isOpened}) async {
    DocumentReference receiverDoc = locator<FirebaseFirestore>()
        .collection(kUserCollection)
        .doc(receiverId)
        .collection(kChatsCollection)
        .doc(sharedRepository.userModel.userId);
    //int count=isOpened?0:1;
    int count = 0;
    if (!isOpened) {
      count++;
    }
    try {
      await receiverDoc.update(
          {'unreadMessagesCount': FieldValue.increment(count)}).then((value) {
        emit(UpdateUnreadMessagesCountSuccessState());
      });
    } catch (e) {
     /* log('updateUnreadMessagesCountOfReceiver: ${e.toString()}');
      emit(UpdateUnreadMessagesCountFailureState(e.toString()));*/
    }
  }

  resetUnreadMessagesToZero({
    required String receiverId,
  }) async {
    try {
      await locator<FirebaseFirestore>()
          .collection(kUserCollection)
          .doc(sharedRepository.userModel.userId)
          .collection(kChatsCollection)
          .doc(receiverId)
          .update({'unreadMessagesCount': 0});
    } catch (e) {
      log('resetUnreadMessagesToZero: $e');
    }
  }
}
