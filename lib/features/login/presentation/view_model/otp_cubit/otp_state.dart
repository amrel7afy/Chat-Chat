
import 'dart:developer';

import '../../../../../core/shared/user_model.dart';

sealed class OTPState {}

final class OTPInitial extends OTPState {}
class OTPLoading extends OTPState {}
class OTPVerified extends OTPState {}



class OTPFailure  extends OTPState {
  final String error;

  OTPFailure (this.error){
    log(error.toString());
  }
}

class OTPFireBaseAuthFailure  extends OTPState {
  final String error;

  OTPFireBaseAuthFailure (this.error){
    log(error.toString());
  }
}

class OTPSetSignedInToTrue extends OTPState {
  final UserModel userModel;

  OTPSetSignedInToTrue(this.userModel);
}

class CacheSaveUserModelSuccess extends OTPState {}

class CacheUserModelFailure  extends OTPState {
  final String error;

  CacheUserModelFailure (this.error){
    log(error.toString());
  }
}
