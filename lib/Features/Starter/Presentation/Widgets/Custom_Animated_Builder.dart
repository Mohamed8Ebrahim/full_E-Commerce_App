// ignore_for_file: file_names

import 'package:e_commerce/Core/Util/Fade_Animation.dart';
import 'package:flutter/material.dart';

class CustomAnimatedBuilder extends StatelessWidget {
  const CustomAnimatedBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: FadeAnimation(
        delay: 1.6,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
