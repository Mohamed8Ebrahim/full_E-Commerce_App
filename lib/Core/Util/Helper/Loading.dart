// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, this.size});
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: const Color.fromARGB(255, 71, 233, 133),
        size: size ?? 50,
      ),
    );
  }
}

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key, this.size});
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.bouncingBall(
        color: const Color.fromARGB(255, 71, 233, 133),
        size: size ?? 50,
      ),
    );
  }
}
