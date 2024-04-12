// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NoItemsMessage extends StatelessWidget {
  const NoItemsMessage({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
