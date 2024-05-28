
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/di/locator.dart';
import 'package:new_chat_with_me/core/shared/user_model.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/shared/chat_model.dart';
import '../../../../../core/shared/shared_repo.dart';
import 'chatting_state.dart';

class ChattingCubit extends Cubit<ChattingState> {
  final SharedRepository sharedRepository;
  ChattingCubit(this.sharedRepository) : super(ChattingInitial());


  signOut()async{
    await locator<FirebaseAuth>().signOut();
  }

  listenToAllChats() async {

    emit(ChattingLoading());
    log('listenToAllChats');
    UserModel userModel=sharedRepository.userModel;
    try {

      var chatStream = locator<FirebaseFirestore>().
          collection(kUserCollection)
          .doc(userModel.userId)
          .collection(kChatsCollection)
          .snapshots();

      chatStream.listen(
            (querySnapshot) {
              sharedRepository.  userChats = querySnapshot.docs
              .map((chatDoc) => ChatModel.fromJson(chatDoc.data()))
              .toList();

          if (sharedRepository.userChats.isEmpty) {
            emit(ChattingNoChats());
          } else {
            emit(ChattingSuccess(sharedRepository.userChats));
            log(sharedRepository.userChats.first.name.toString());
          }
        },
        onError: (e) {
          log('getAllChats stream error: $e');
          emit(ChattingNoChats());
          // emit(ChatGetUserChatsFailureState(e.toString()));
        },
      );
    } catch (e) {
      log('getAllChats initialization error: $e');
      emit(ChattingNoChats());
      // emit(ChatGetUserChatsFailureState(e.toString()));
    }
  }
}
