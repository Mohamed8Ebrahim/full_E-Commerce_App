// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileViewImage extends StatelessWidget {
  const ProfileViewImage({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      width: 130.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10.h,
            right: 10.w,
            child: Container(
              height: 33.h,
              width: 35.w,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 71, 233, 133),
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(28.spMax),
              ),
              child: InkWell(
                onTap: () async {},
                child: Icon(
                  Icons.camera_alt_sharp,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
