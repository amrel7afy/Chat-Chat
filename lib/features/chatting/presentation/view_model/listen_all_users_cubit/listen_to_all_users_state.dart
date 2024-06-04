
import 'dart:developer';

import 'package:new_chat_with_me/core/shared/user_model.dart';

sealed class ListenToAllUsersState {}

final class ListenToAllUsersInitial extends ListenToAllUsersState {}
final class  ListenToAllUsersLoading extends ListenToAllUsersState {}

final class ListenToAllUserSuccess extends ListenToAllUsersState {
  final List<UserModel> users;

  ListenToAllUserSuccess(this.users);
}

final class ListenToAllUserFailure extends ListenToAllUsersState {
  final String error;

  ListenToAllUserFailure(this.error) {
    log(error.toString());
  }
}
