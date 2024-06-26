import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theming/my_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../data/model/message_model.dart';

class OtherChatBubble extends StatelessWidget {
  final MessageModel messageModel;

  const OtherChatBubble({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(messageModel.dateTime);
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 20),
      backGroundColor: MyColors.kPrimaryColor.withOpacity(0.45),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${messageModel.message} ',
              style: MyTextStyles.font11Weight600.copyWith(color: Colors.white),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('h:mm a').format(dateTime),
          style: MyTextStyles.font11Weight600.copyWith(color: Colors.white,fontSize: 10, fontWeight: FontWeight.w900)

                ),
                const SizedBox(width: 3,),
                const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyChatBubble extends StatelessWidget {
  final MessageModel messageModel;

  const MyChatBubble({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(messageModel.dateTime);
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(top: 20),
      backGroundColor: MyColors.kPrimaryColor,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${messageModel.message} ',
              style: MyTextStyles.font14Weight600.copyWith(color: Colors.white),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('h:mm a').format(dateTime),
                    style: MyTextStyles.font11Weight600.copyWith(color: Colors.white,fontSize: 10, fontWeight: FontWeight.w900)

                ),
                const SizedBox(width: 3,),
                const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
