import 'dart:io';

import 'package:new_chat_with_me/core/shared/user_model.dart';

import 'chat_model.dart';

class SharedRepository {

  UserModel userModel=UserModel(email: 'email', userId: '', name: 'default name', bio: 'bio', phoneNumber: 'phoneNumber', profilePic: 'profilePic');
  File? image;
  List<UserModel> users = [];
  List<ChatModel> userChats = [];
}