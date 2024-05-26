
import 'dart:developer';

sealed class LoginState {}

final class LoginInitial extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState(this.error){
    log(error.toString());
  }
}
class LoginFireBaseAuthErrorState extends LoginState {
  final String error;

  LoginFireBaseAuthErrorState(this.error){
    log(error.toString());
  }
}
class OTPSentState extends LoginState  {
  String verificationId;

  OTPSentState(this.verificationId);
}

