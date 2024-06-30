import 'dart:developer';
import 'dart:io';

import 'package:new_chat_with_me/core/shared/user_model.dart';


class SharedRepository {

  UserModel userModel=UserModel(email: '', userId: '', name: '', bio: '', phoneNumber: '', profilePic: '', unreadMessagesCount: 0);
  File? image;
  List<UserModel> users = [];
  List<UserModel> userChats = [];

  printUserModel(){
    log(userModel.toString());
  }
}