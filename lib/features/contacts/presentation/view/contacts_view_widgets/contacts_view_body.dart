import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/AppRouter.dart';
import 'package:new_chat_with_me/core/theming/my_colors.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/custom_error_message.dart';
import '../../../../../core/widgets/loading_indicator.dart';
import '../../view_model/check_contact_cubit/check_contacts_cubit.dart';
import '../../view_model/check_contact_cubit/check_contacts_state.dart';
import 'contact_builder.dart';


class ContactsViewBody extends StatefulWidget {
  const ContactsViewBody({super.key});

  @override
  State<ContactsViewBody> createState() => _ContactsViewBodyState();
}

class _ContactsViewBodyState extends State<ContactsViewBody> {
  @override
  void initState() {
    getContacts().then((value) => context
        .read<CheckContactsCubit>()
        .getMatchedUsersWithContacts(context));
    super.initState();
  }

  Future<void> getContacts() async {
    await context.read<CheckContactsCubit>().getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: kLeftHomeViewPadding,),
            child: BlocBuilder<CheckContactsCubit, CheckContactsState>(
              builder: (BuildContext context, state) {
                if (state is CheckNoContactsState) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomErrorMessage( errorMessage: state.error,),
                  );
                } else if (state is CheckGetContactsSuccessState) {
                  return haveContactsSuccessBody(state);
                } else if (state is CheckNoMatchedContactsState) {
                  return CustomErrorMessage(errorMessage: state.error);
                } else {
                  return const CustomLoadingIndicator();
                }
              },
            )


    );
  }

  ListView haveContactsSuccessBody(CheckGetContactsSuccessState state) {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRouter.messagingView,
                  arguments: context
                      .read<CheckContactsCubit>()
                      .matchedUsersWithContacts[index]);
            },
            child: ContactItemBuilder(
              userModel: state.contacts[index],
            ),
          );
      },
      itemCount: state.contacts.length,
    );
  }

  Center buildNoContactWidget(state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.error,
            style: MyTextStyles.font14Weight600.copyWith(color: MyColors.kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
