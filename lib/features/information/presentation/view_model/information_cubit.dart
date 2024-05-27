
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_chat_with_me/core/shared/shared_repo.dart';

import '../../../../core/helper/app_regex.dart';
import 'information_state.dart';

class InformationCubit extends Cubit<InformationState> {
  final SharedRepository sharedRepository;
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController bioController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  InformationCubit(this.sharedRepository) : super(InformationInitial());



  nameValidator(String? value) {
    if (value == null || value.isEmpty||!AppRegex.hasUpperCase(value)) {
      return 'Please, enter a valid phone number.';
    }
    return null;
  }
  emailValidator(String? value) {
    if (value == null || value.isEmpty||!AppRegex.isEmailValid(value)) {
      return 'Please, enter a valid email.';
    }
    return null;
  }
  bioValidator(String? value) {
    if (value == null || value.isEmpty||!AppRegex.isEmailValid(value)) {
      return 'Please, enter a valid bio.';
    }
    return null;
  }


  Future<File?> pickImage() async {
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        sharedRepository.image = File(pickedImage.path);
        emit(PickImageSuccess());
      } else {
        emit(PickImageFailure('No image selected'));
      }
    } catch (e) {
      log(e.toString());
      emit(PickImageFailure(e.toString()));
    }
    return sharedRepository.image;
  }
}
