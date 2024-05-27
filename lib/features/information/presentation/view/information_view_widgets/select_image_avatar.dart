import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/di/locator.dart';
import 'package:new_chat_with_me/core/shared/shared_repo.dart';

import '../../../../../core/theming/my_colors.dart';

class SelectImageAvatar extends StatefulWidget {
   SelectImageAvatar({
    super.key,
  });

  @override
  State<SelectImageAvatar> createState() => _SelectImageAvatarState();
}

class _SelectImageAvatarState extends State<SelectImageAvatar> {
  bool checkImageFileIfNull() {
    return locator<SharedRepository>().image == null;
  }

  CircleAvatar getImageFileAvatar(BuildContext context) {
    var userModelImage = locator<SharedRepository>().userModel.profilePic;
    if (checkImageFileIfNull()) {
      if (userModelImage.isNotEmpty && Uri.tryParse(userModelImage)?.hasAbsolutePath == true) {
        return networkAvatar(userModelImage);
      } else {
        return  assetAvatar();
      }
    }

    return pickedAvatar();

  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 60.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Builder(builder: (context) {
          return getImageFileAvatar(context);
        }));
  }

  CircleAvatar pickedAvatar() {
    return CircleAvatar(
      radius: 45,
      backgroundColor: MyColors.kPrimaryColor,
      backgroundImage: FileImage(locator<SharedRepository>().image!),
    );
  }

  CircleAvatar assetAvatar() {
    return const CircleAvatar(
      radius: 45.0,
      backgroundColor: Colors.blueGrey,
      backgroundImage: AssetImage('assets/images/profile.png'),
    );
  }

  CircleAvatar networkAvatar(String userModelImage) {
    return CircleAvatar(
      radius: 45.0,
      backgroundColor: Colors.blueGrey,
      backgroundImage: NetworkImage(userModelImage),
    );
  }

}
