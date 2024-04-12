import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlreadyHaveAnAccountWidget extends StatelessWidget {
  const AlreadyHaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Already have an account ? ',
            style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xff939393),
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () => {Navigator.pop(context)},
            child: Text(
              'Log-in',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xff748288),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
