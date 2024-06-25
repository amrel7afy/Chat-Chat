

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/di/locator.dart';
import '../../../../../core/shared/shared_repo.dart';
import '../../../../../core/shared/user_model.dart';
import 'add_reciever_chat_data_state.dart';



class AddReceiverChatDataCubit extends Cubit<AddReceiverChatDataState> {
  final SharedRepository sharedRepository;
  //عشان نضيف بيانات الشخص اللي هتبعتله رساله ونسدعي الميثود مرة واحدة فقط
  bool isReceiverChatDataIsAdded = false;
  final FirebaseFirestore fireStore = locator<FirebaseFirestore>();

  AddReceiverChatDataCubit(  this.sharedRepository) : super(AddReceiverChatDataInitial());


   addReceiverChatData(UserModel receiverUserModel, ) async {
    UserModel userModel=receiverUserModel;
    UserModel myUserModel=sharedRepository.userModel;
 try{
   await fireStore
       .collection(kUserCollection)
       .doc(sharedRepository.userModel.userId)
       .collection(kChatsCollection)
       .doc(receiverUserModel.userId)
       .set(userModel.toJson());
   fireStore
        .collection(kUserCollection)
        .doc(receiverUserModel.userId)
        .collection(kChatsCollection)
        .doc(sharedRepository.userModel.userId)
        .set(myUserModel.toJson())
          .then((value) {
            emit(AddReceiverChatDataToFireBaseSuccess());
      }).catchError((e){
        emit(ReceiverChatDataIsAddedToFireBaseFailure(e.toString()));
      });
 }catch(e){  emit(ReceiverChatDataIsAddedToFireBaseFailure(e.toString()));}


  }




}
