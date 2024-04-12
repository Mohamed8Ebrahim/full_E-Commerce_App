// ignore_for_file: file_names

import 'package:e_commerce/Core/Util/Fade_Animation.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      delay: 1.8,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Center(
          child: Text(
            'Create Account',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
