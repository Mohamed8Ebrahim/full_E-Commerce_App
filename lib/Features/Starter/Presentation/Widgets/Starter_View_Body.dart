// ignore_for_file: file_names

import 'package:e_commerce/Core/Util/App_Router.dart';
import 'package:e_commerce/Core/Util/Fade_Animation.dart';
import 'package:e_commerce/Features/Starter/Presentation/Widgets/Create_Account_Button.dart';
import 'package:e_commerce/Features/Starter/Presentation/Widgets/Custom_Animated_Builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class StarterViewBody extends StatelessWidget {
  const StarterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FadeAnimation(
            delay: 1,
            child: Text(
              'Brand New Perspective',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          FadeAnimation(
            delay: 1.3,
            child: Text(
              'Let\'s Start with our summer collection',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
              ),
            ),
          ),
          SizedBox(height: 80.h),
          InkWell(
            onTap: () {
              GoRouter.of(context).push(AppRouter.login);
            },
            child: const CustomAnimatedBuilder(),
          ),
          SizedBox(height: 28.h),
          InkWell(
              onTap: () {
                GoRouter.of(context).push(AppRouter.register);
              },
              child: const CreateAccountButton()),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
