import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/di/locator.dart';
import 'package:new_chat_with_me/core/shared/user_model.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/shared/shared_repo.dart';
import 'listen_to_all_chats_state.dart';

class ListenToAllChatsCubit extends Cubit<ListenToAllChatsState> {
  final SharedRepository sharedRepository;
  ListenToAllChatsCubit(this.sharedRepository) : super(ListenToAllChatsInitial());

  signOut() async {
    await locator<FirebaseAuth>().signOut();
  }


  listenToAllChats() async {
    emit(ListenToAllChatsLoading());
    log('listenToAllChats:${sharedRepository.userModel.userId}');
    UserModel userModel = sharedRepository.userModel;

    try {
      locator<FirebaseFirestore>()
          .collection(kUserCollection)
          .doc(userModel.userId)
          .collection(kChatsCollection)
          .snapshots()
          .listen(
            (querySnapshot) {
          sharedRepository.userChats = querySnapshot.docs
              .map((chatDoc) => UserModel.fromJson(chatDoc.data()))
              .toList();

          if (sharedRepository.userChats.isEmpty) {
            emit(ListenToAllChatsNoChats());
          } else {
            sharedRepository.userChats.removeWhere((element) =>
            element.phoneNumber == sharedRepository.userModel.phoneNumber);
            emit(ListenToAllChatsSuccess(sharedRepository.userChats));
            //log(sharedRepository.userChats?.first.name.toString()??'');
          }
        },
        onError: (e) {
          log('getAllChats stream error: $e');
          emit(ListenToAllChatsNoChats());
          // emit(ChatGetUserChatsFailureState(e.toString()));
        },
      );
    } catch (e) {
      log('getAllChats initialization error: $e');
      emit(ListenToAllChatsNoChats());
      // emit(ChatGetUserChatsFailureState(e.toString()));
    }
  }


}
