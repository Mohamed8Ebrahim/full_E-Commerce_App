// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onPressed});
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(8),
        minimumSize: MaterialStateProperty.all(Size(250.w, 40.h)),
        backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 33, 40, 243)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
