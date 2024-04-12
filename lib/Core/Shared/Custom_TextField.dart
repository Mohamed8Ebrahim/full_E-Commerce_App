// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      this.suffixIcon = false,
      this.controller,
      this.color = Colors.white,
      this.onChanged,
      this.enabled = true,
      this.prefixIcon});
  final String hintText;
  final bool obscureText;
  final bool suffixIcon;
  final TextEditingController? controller;
  final Color? color;
  final void Function(String)? onChanged;
  final bool enabled;
  final Widget? prefixIcon;
  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.spMin),
            decoration: BoxDecoration(
              color: widget.color,
              border: Border(
                bottom:
                    BorderSide(color: Colors.grey[100] ?? Colors.transparent),
              ),
            ),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else {
                  return null;
                }
              },
              onChanged: widget.onChanged,
              controller: widget.controller,
              obscureText: (widget.obscureText && _obscureText),
              decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: Colors.black54,
                        ),
                      )
                    : null,
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.grey[400]),
                enabled: widget.enabled,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
