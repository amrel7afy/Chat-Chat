
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/di/locator.dart';
import '../../../../../core/shared/shared_repo.dart';
import 'unread_messages_count_state.dart';

class UnreadMessagesCountCubit extends Cubit<UnreadMessagesCountState> {
  final SharedRepository sharedRepository;

  UnreadMessagesCountCubit(  this.sharedRepository) : super(UnreadMessagesCountInitial());



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
          }else{
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
}
