
import 'dart:developer';

import '../../../../core/shared/user_model.dart';

sealed class InformationState {}

final class InformationInitial extends InformationState {}
final class InformationLoading extends InformationState {}

final class InformationFailure extends InformationState {
  final String error;
  InformationFailure (this.error){
    log(error.toString());
  }
}

class InformationPickImageSuccess extends InformationState {}
class InformationPickImageFailure  extends InformationState {
  final String error;

  InformationPickImageFailure (this.error){
    log(error.toString());
  }
}
class InformationStoringFireStoreErrorState extends InformationState {
  String error;

  InformationStoringFireStoreErrorState(this.error) {
    log(error);
  }
}

class InformationSuccess extends InformationState {
  UserModel? userModel;

  InformationSuccess([this.userModel]);
}
final class InformationStoringUserFireStoreSuccess extends InformationState {}
