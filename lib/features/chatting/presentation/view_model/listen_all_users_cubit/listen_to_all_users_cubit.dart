import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/di/locator.dart';
import '../../../../../core/shared/shared_repo.dart';
import '../../../../../core/shared/user_model.dart';
import 'listen_to_all_users_state.dart';

class ListenToAllUsersCubit extends Cubit<ListenToAllUsersState> {
  final SharedRepository sharedRepository;

  ListenToAllUsersCubit(this.sharedRepository)
      : super(ListenToAllUsersInitial());

  listenToAllUsers() async {
    emit(ListenToAllUsersLoading());
    try {
      var chatStream =
          locator<FirebaseFirestore>().collection(kUserCollection).snapshots();
      chatStream.listen(
        (querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            for (var snapshot in querySnapshot.docs) {
              removeExistingUserFromList(snapshot);
            }
            emit(ListenToAllUserSuccess(sharedRepository.users));
          }
        },
        onError: (e) {
          log('getAllChats stream error: $e');
          emit(ListenToAllUserFailure(e.toString()));
        },
      );
    } catch (e) {
      log('getAllChats initialization error: $e');
      emit(ListenToAllUserFailure(e.toString()));
    }
  }

  void removeExistingUserFromList(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
     if(sharedRepository.userModel.userId!=snapshot.data()['uid']){
      sharedRepository.users.add(UserModel.fromJson(snapshot.data()));
    }
  }
}
