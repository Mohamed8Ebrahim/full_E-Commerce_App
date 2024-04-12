// ignore_for_file: file_names

import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Profile_View.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Profile_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.widget,
  });

  final ProfileView widget;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.grey,
        ),
      ),
      automaticallyImplyLeading: false,
      expandedHeight: 350.h,
      title: const Text('Profile'),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Stack(
          children: [
            Image.asset(
              'asset/prof_back.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileImage(userModel: widget.userData),
                  Text(
                    widget.userData.name!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    widget.userData.email!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
