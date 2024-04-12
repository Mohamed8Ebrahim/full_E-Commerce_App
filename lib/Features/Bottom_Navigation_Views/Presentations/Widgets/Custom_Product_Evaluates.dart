// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductEvaluates extends StatelessWidget {
  const CustomProductEvaluates({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.spMin),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 33.h,
                width: 48.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 129, 129),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    "New",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              const Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 255, 191, 0),
                  ),
                  Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 255, 191, 0),
                  ),
                  Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 255, 191, 0),
                  ),
                  Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 255, 191, 0),
                  ),
                  Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 255, 191, 0),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.edit_location,
                color: const Color.fromARGB(255, 76, 141, 95),
                size: 28.sp,
              ),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
