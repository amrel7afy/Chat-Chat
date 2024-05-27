import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_chat_with_me/core/di/locator.dart';
import 'package:new_chat_with_me/core/shared/shared_repo.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/methods.dart';
import '../../../../core/helper/app_regex.dart';
import '../../../../core/helper/cache_helper.dart';
import '../../../../core/shared/methods.dart';
import 'information_state.dart';


class InformationCubit extends Cubit<InformationState> {
  final SharedRepository sharedRepository;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  InformationCubit(this.sharedRepository) : super(InformationInitial());

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty || !AppRegex.hasUpperCase(value)) {
      return 'Please, enter a valid name.';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty || !AppRegex.isEmailValid(value)) {
      return 'Please, enter a valid email.';
    }
    return null;
  }

  String? bioValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please, enter a valid bio.';
    }
    return null;
  }

  String? imageValidator() {
    if (sharedRepository.image == null) {
      return 'Selecting your image is required';
    }
    return null;
  }

  Future<File?> pickImage() async {
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        sharedRepository.image = File(pickedImage.path);
        emit(InformationPickImageSuccess());
      } else {
        emit(InformationPickImageFailure('No image selected'));
      }
    } catch (e) {
      log(e.toString());
      emit(InformationPickImageFailure(e.toString()));
    }
    return sharedRepository.image;
  }

  Future createUserToFireStore() async {
    emit(InformationLoading());
    try {
      File compressedFile = await compressImage(sharedRepository.image!);
      await storeFileToStorage(
          "profilePic/${locator<FirebaseAuth>().currentUser!.uid}", compressedFile)
          .then((value) {
        assignUserData(value);
        emit(InformationStoringUserFireStoreSuccess());
      });
      await locator<FirebaseFirestore>()
          .collection(kUserCollection)
          .doc(sharedRepository.userModel.userId)
          .set(sharedRepository.userModel.toJson())
          .then((value) async {
        await saveUserToSP(sharedRepository.userModel);
        await CacheHelper.saveData(key: isSignedInKey, value: true);
        emit(InformationSuccess(sharedRepository.userModel));
      });
    } catch (e) {
      log(e.toString());
      emit(InformationStoringFireStoreErrorState(e.toString()));
    }
  }

  void assignUserData(String value) {
    String phoneNumberWithoutCountryCode =
    removeSubString((locator<FirebaseAuth>().currentUser!.phoneNumber!), '+2');
    sharedRepository.userModel.phoneNumber = phoneNumberWithoutCountryCode;
    sharedRepository.userModel.profilePic = value;
    sharedRepository.userModel.userId = locator<FirebaseAuth>().currentUser!.phoneNumber!;
    sharedRepository.userModel.email = emailController.text.trim();
    sharedRepository.userModel.name = nameController.text.trim();
    sharedRepository.userModel.bio = bioController.text.trim();
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    try {
      UploadTask uploadTask = locator<FirebaseStorage>().ref().child(ref).putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      log('storeFileToStorage$e');
      emit(InformationStoringFireStoreErrorState(e.toString()));
      return '';
    }
  }
}

