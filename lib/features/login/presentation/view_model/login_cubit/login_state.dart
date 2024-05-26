
import 'dart:developer';

import '../../../../../core/shared/user_model.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}

class LoginFailure  extends LoginState {
  final String error;

  LoginFailure (this.error){
    log(error.toString());
  }
}
class LoginFireBaseAuthFailure  extends LoginState {
  final String error;

  LoginFireBaseAuthFailure (this.error){
    log(error.toString());
  }
}
class OTPSent extends LoginState  {
  String verificationId;

  OTPSent(this.verificationId);
}
class CacheSetSignedInToTrue extends LoginState {
  final UserModel userModel;

  CacheSetSignedInToTrue(this.userModel);
}

