
import '../../../../../core/shared/user_model.dart';

 class CheckContactsState {}

 class CheckContactsInitial extends CheckContactsState {}
 class CheckContactsLoading extends CheckContactsState {}

class CheckGetContactsSuccessState extends CheckContactsState {
  List<UserModel> contacts;
  CheckGetContactsSuccessState(this.contacts);
}

class CheckNoContactsState extends CheckContactsState {
  String error;

  CheckNoContactsState(this.error);
}class CheckNoMatchedContactsState extends CheckContactsState {
  String error;

  CheckNoMatchedContactsState(this.error);
}
