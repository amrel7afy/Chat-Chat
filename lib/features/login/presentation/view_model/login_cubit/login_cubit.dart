import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/di/locator.dart';
import 'package:new_chat_with_me/core/helper/app_regex.dart';

import '../../../../../core/shared/shared_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SharedRepository sharedRepository;
  TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginCubit(this.sharedRepository) : super(LoginInitial());

  phoneValidator(String? value) {
    if (value == null || value.isEmpty||!AppRegex.isPhoneNumberValid(value)) {
      return 'Please, enter a valid phone number.';
    }
    return null;
  }




  login(BuildContext context, String phoneNumber) async {
    emit(LoginLoading());
    try {
      await locator<FirebaseAuth>().verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,

        codeSent: (String verificationId, int? resendToken) async {
          emit(OTPSent(verificationId));
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
    } on FirebaseAuthException catch (e) {
      emit(LoginFireBaseAuthFailure(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(LoginFailure(e.toString()));
    }
  }

  verificationCompleted(PhoneAuthCredential credential) async {
    await locator<FirebaseAuth>().signInWithCredential(credential);
  }

  verificationFailed(FirebaseAuthException e) {
    if (e.code == 'invalid-phone-number') {
      emit(LoginFireBaseAuthFailure('Enter a valid phone number.'));
    }
    else{
      emit(LoginFireBaseAuthFailure(e.message.toString()));
    }

    // Handle other errors
  }
}
