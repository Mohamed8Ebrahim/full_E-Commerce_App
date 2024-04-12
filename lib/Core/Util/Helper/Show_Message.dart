// ignore_for_file: file_names

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ShowMessage {
  void showMessage(String message, context, color) {
    showToast(
      message,
      context: context,
      backgroundColor: color,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      animDuration: const Duration(milliseconds: 700),
      duration: const Duration(seconds: 5),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  void showCherryToastSuccess(String message, context) {
    CherryToast.success(
      animationCurve: Curves.fastOutSlowIn,
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(milliseconds: 700),
      description: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
    ).show(context);
  }

  void showCherryToastError(String message, context) {
    CherryToast.error(
      animationDuration: const Duration(milliseconds: 700),
      animationType: AnimationType.fromLeft,
      description: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
    ).show(context);
  }
}
