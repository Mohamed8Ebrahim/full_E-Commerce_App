// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ViewsBackground extends StatelessWidget {
  const ViewsBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.bottomRight,
              begin: Alignment.topLeft,
              colors: [
                Colors.tealAccent.shade100,
                Colors.white,
                Colors.green.shade100,
              ]),
        ),
        child: child);
  }
}

class RegisterationBackground extends StatelessWidget {
  const RegisterationBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'asset/wave-haikei.png',
                ),
                fit: BoxFit.fitHeight)),
        child: child);
  }
}
