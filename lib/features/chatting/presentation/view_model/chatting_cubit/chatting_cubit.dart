
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/di/locator.dart';

import '../../../../../core/shared/shared_repo.dart';
import 'chatting_state.dart';

class ChattingCubit extends Cubit<ChattingState> {
  final SharedRepository sharedRepository;
  ChattingCubit(this.sharedRepository) : super(ChattingInitial());
  signOut()async{
    await locator<FirebaseAuth>().signOut();

  }
}
