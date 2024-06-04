import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/widgets/custom_error_message.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/loading_indicator.dart';
import '../../view_model/listen_to_all_chats_cubit/listen_to_all_chats_cubit.dart';
import '../../view_model/listen_to_all_chats_cubit/listen_to_all_chats_state.dart';
import 'all_chats_success_body.dart';

class AllChatsViewBody extends StatefulWidget {
  const AllChatsViewBody({super.key});

  @override
  State<AllChatsViewBody> createState() => _AllChatsViewBodyState();
}

class _AllChatsViewBodyState extends State<AllChatsViewBody> {
  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kLeftHomeViewPadding),
      child: BlocBuilder<ListenToAllChatsCubit, ListenToAllChatsState>(
        builder: (context, state) {
           if (state is ListenToAllChatsSuccess) {
            return  ChatSuccessBody( chats:state.chats);
          }
          else if(state is ListenToAllChatsNoChats){
            return const CustomErrorMessage(errorMessage: 'No Chats');
          }
          else{
            return const CustomLoadingIndicator();
          }
        },
      ),
    );
  }
}
