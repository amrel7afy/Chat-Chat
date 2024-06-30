import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/helper/extensions.dart';

import '../../../../core/di/locator.dart';
import '../../../../core/shared/shared_repo.dart';
import '_view_widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: (){context.pop();
        locator<SharedRepository>().image=null;
        },child: const Icon(Icons.arrow_back),),
      ),
      body:  const SafeArea(child: const ProfileViewBody()),
    );
  }
}
