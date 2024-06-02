import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_chat_with_me/core/widgets/custom_error_message.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/chatting_cubit/chatting_cubit.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/chatting_cubit/chatting_state.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/loading_indicator.dart';
import 'all_chats_success_body.dart';

class AllChatsViewBody extends StatelessWidget {
  const AllChatsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kLeftHomeViewPadding),
      child: BlocBuilder<ChattingCubit, ChattingState>(
        builder: (context, state) {
           if (state is ChattingSuccess) {
            return  ChatSuccessBody( chats:state.chats);
          }
          else if(state is ChattingNoChats){
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
