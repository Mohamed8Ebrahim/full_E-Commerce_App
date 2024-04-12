// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';

class FadeAnimation extends StatelessWidget {
  const FadeAnimation({super.key, required this.delay, required this.child});
  final num delay;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(
        "opacity",
        Tween(
          begin: 0.0,
          end: 1.0,
        ),
        duration: const Duration(milliseconds: 500),
      ).thenTween(
        "y",
        Tween(begin: 150.0, end: 0.0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
      );
    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      tween: tween,
      duration: tween.duration,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.get('opacity'),
          child: Transform.translate(
            offset: Offset(0, value.get('y')),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
