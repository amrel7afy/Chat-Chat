
import 'dart:developer';

import '../../../../core/shared/user_model.dart';

sealed class InformationState {}

final class InformationInitial extends InformationState {}
final class InformationLoading extends InformationState {}
final class InformationFailure extends InformationState {}

class PickImageSuccess extends InformationState {}
class PickImageFailure  extends InformationState {
  final String error;

  PickImageFailure (this.error){
    log(error.toString());
  }
}
class StoringFireStoreErrorState extends InformationState {
  String error;

  StoringFireStoreErrorState(this.error) {
    log(error);
  }
}

class CacheSetSignedInToTrueState extends InformationState {
  UserModel userModel;

  CacheSetSignedInToTrueState(this.userModel);
}
