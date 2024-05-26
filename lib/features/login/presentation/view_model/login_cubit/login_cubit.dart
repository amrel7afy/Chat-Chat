import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/helper/app_regex.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginCubit() : super(LoginInitial());

  phoneValidator(String? value) {
    if (value == null || value.isEmpty||!AppRegex.isPhoneNumberValid(value)) {
      return 'Please, enter a valid phone number.';
    }
    return null;
  }
}
