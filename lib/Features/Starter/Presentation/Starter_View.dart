// ignore_for_file: file_names

import 'package:e_commerce/Features/Starter/Presentation/Widgets/Starter_View_Body.dart';
import 'package:flutter/material.dart';

class StarterView extends StatelessWidget {
  const StarterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/one.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
              Colors.black.withOpacity(.9),
              Colors.black.withOpacity(.3),
            ]),
          ),
          child: const StarterViewBody(),
        ),
      ),
    );
  }
}
