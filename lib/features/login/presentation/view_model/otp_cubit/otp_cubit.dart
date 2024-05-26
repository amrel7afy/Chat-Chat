import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/AppRouter.dart';
import 'package:new_chat_with_me/core/di/locator.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/helper/cache_helper.dart';
import '../../../../../core/shared/shared_repo.dart';
import '../../../../../core/shared/user_model.dart';

import 'otp_state.dart';

class OTPCubit extends Cubit<OTPState> {
  final SharedRepository sharedRepository;

  OTPCubit(this.sharedRepository) : super(OTPInitial());
  String? otpCode;

  verifyOTP({
    required String verificationId,
    required String userOTP,
  }) async {
    emit(OTPLoading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);
      User? user =
          (await locator<FirebaseAuth>().signInWithCredential(credential)).user;
      if (user != null) {
        sharedRepository.userModel = UserModel(
            email: user.email ?? '',
            userId: user.phoneNumber.toString(),
            bio: '',
            phoneNumber: '',
            profilePic: '',
            name: '');

        emit(OTPVerified());
      }
    } on FirebaseAuthException catch (e) {
      emit(OTPFireBaseAuthFailure(e.toString()));
    }
  }

  verifyOtp(context, otpCode, verificationId) async {
    verifyOTP(
      verificationId: verificationId,
      userOTP: otpCode,
    );
    bool isUserExists = await checkExistingUser();
    if (isUserExists) {
      getTheUserFromFireStoreWithVerifiedUserID();
    } else {
      Navigator.pushReplacementNamed(context, AppRouter.informationView);
    }
  }

  Future<bool> checkExistingUser() async {
    try {
      DocumentSnapshot documentSnapshot = await locator<FirebaseFirestore>()
          .collection(kUserCollection)
          .doc(sharedRepository.userModel.userId)
          .get();
      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      emit(OTPFailure(e.toString()));
      return false;
    }
  }

  getTheUserFromFireStoreWithVerifiedUserID() async {
    if (sharedRepository.userModel.userId.isNotEmpty) {
      DocumentSnapshot documentSnapshot = await locator<FirebaseFirestore>()
          .collection(kUserCollection)
          .doc(sharedRepository.userModel.userId)
          .get();
      sharedRepository.userModel = UserModel(
          userId: documentSnapshot['uid'],
          email: documentSnapshot['email'],
          name: documentSnapshot['name'],
          bio: documentSnapshot['bio'],
          phoneNumber: documentSnapshot['phoneNumber'],
          profilePic: documentSnapshot['profilePic']);
      log('getUserFromFireStore');
      await saveUserToSP().then((value) {
        setIsSignedInKeyToTrue();
      });
    }
  }

  //setCacheSignedIn
  Future setIsSignedInKeyToTrue() async {
    await CacheHelper.saveData(key: isSignedInKey, value: true);
    emit(OTPSetSignedInToTrue(sharedRepository.userModel));
  }

  Future saveUserToSP() async {
    try {
      String userJson = jsonEncode(sharedRepository.userModel.toJson());
      await CacheHelper.saveData(
        key: userModelKey,
        value: userJson,
      );
      emit(CacheSaveUserModelSuccess());
    } catch (e) {
      log(e.toString());
      emit(CacheUserModelFailure(e.toString()));
    }
  }
}
