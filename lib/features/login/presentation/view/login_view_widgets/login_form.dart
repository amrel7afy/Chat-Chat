import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';
import 'package:new_chat_with_me/core/widgets/cutom_form_field.dart';
import 'package:new_chat_with_me/core/widgets/phone_country_code_selector.dart';
import 'package:new_chat_with_me/core/widgets/vertical_and_horizontal_space.dart';
import 'package:new_chat_with_me/features/login/presentation/view/login_view_widgets/login_animated_progress_button.dart';
import 'package:new_chat_with_me/features/login/presentation/view_model/login_cubit/login_cubit.dart';
import '../../../../../core/theming/styles.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key:context.read<LoginCubit>().formKey ,
      child: Column(children: [
        CustomTextFormField(
            prefixIcon: const PhoneCountryCodeSelector(
              backGroundColor: MyColors.kGifBackGroundColor,
            ),
            borderRadius: 10,
            backgroundColor: MyColors.kGifBackGroundColor,
            hintText: 'Enter your phone number',
            hintStyle: MyTextStyles.font14Weight500,
            controller:
            context.read<LoginCubit>().phoneNumberController,
            validator: context.read<LoginCubit>().phoneValidator),
        const VerticalSpacer(40),
        LoginAnimatedProgressButton(onPressed: (){
          if(context.read<LoginCubit>().formKey.currentState!.validate()){

          }

        }),
      ],),);
  }
}