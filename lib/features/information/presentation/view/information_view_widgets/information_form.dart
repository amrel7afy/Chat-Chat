
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';
import 'package:new_chat_with_me/core/widgets/cutom_form_field.dart';
import '../../../../../core/widgets/vertical_and_horizontal_space.dart';
import '../../view_model/information_cubit.dart';

class InformationForm extends StatelessWidget {
  const InformationForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context
          .read<InformationCubit>()
          .formKey,
        child: Column(
          children: [
            CustomTextFormField(
                hintText: 'Enter your name',
                controller:
                context.read<InformationCubit>().nameController,
                backgroundColor: MyColors.kGifBackGroundColor,
                validator:
                context.read<InformationCubit>().nameValidator),
            const VerticalSpacer(15),
            CustomTextFormField(
                hintText: 'abc@example.com',
                backgroundColor: MyColors.kGifBackGroundColor,
                controller: context
                    .read<InformationCubit>()
                    .emailController,
                validator: context
                    .read<InformationCubit>()
                    .emailValidator),
            const VerticalSpacer(15),
            CustomTextFormField(
                hintText: 'Enter your bio',
                backgroundColor: MyColors.kGifBackGroundColor,
                controller:
                context.read<InformationCubit>().bioController,
                validator:
                context.read<InformationCubit>().bioValidator),
          ],
        ));
  }
}