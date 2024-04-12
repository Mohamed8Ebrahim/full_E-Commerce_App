import 'package:e_commerce/Core/Util/App_Router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account ? ',
            style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xff939393),
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () => {GoRouter.of(context).push(AppRouter.register)},
            child: Text(
              'Sign-up',
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
