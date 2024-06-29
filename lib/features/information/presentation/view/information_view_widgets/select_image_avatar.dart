import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:new_chat_with_me/core/di/locator.dart';
import 'package:new_chat_with_me/core/shared/shared_repo.dart';

import '../../../../../core/theming/my_colors.dart';

class SelectImageAvatar extends StatelessWidget {
  SelectImageAvatar({super.key});

  bool checkImageFileIfNull() {
    return locator<SharedRepository>().image == null;
  }

  Future<String> getDownloadUrl(String ref) async {
    try {
      String downloadUrl = await locator<FirebaseStorage>().ref().child(ref).getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log('getDownloadUrl Error: $e');
      throw Exception('Could not get download URL');
    }
  }

  Future<CircleAvatar> getImageFileAvatar(BuildContext context) async {
    var userModelImage = locator<SharedRepository>().userModel.profilePic;
    if (checkImageFileIfNull()) {
      if (userModelImage.isNotEmpty && Uri.tryParse(userModelImage)?.hasAbsolutePath == true) {
        String downloadUrl = await getDownloadUrl('profilePic/${locator<FirebaseAuth>().currentUser!.uid}');
        return networkAvatar(downloadUrl);
      } else {
        return assetAvatar();
      }
    }
    return pickedAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: FutureBuilder<CircleAvatar>(
        future: getImageFileAvatar(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return assetAvatar();
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
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
      backgroundColor: MyColors.kLightGreyColor,
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

