// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:e_commerce/Features/Registeration/Manager/Register_Cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatefulWidget {
  const PickImageWidget({
    super.key,
  });

  @override
  State<PickImageWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  String? _image;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return SizedBox(
          width: 115.w,
          height: 115.h,
          child: _image == null
              ? CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: const AssetImage("asset/avatar.png"),
                  child: Stack(
                    children: [
                      Positioned.fromRect(
                        rect: Rect.fromLTWH(70, 70, 36.w, 40.h),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(50.spMax),
                          ),
                          child: InkWell(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 80);
                              if (image != null) {
                                setState(() {
                                  _image = image.path;
                                });
                                BlocProvider.of<RegisterCubit>(context)
                                    .profilePic = (File(_image!));
                              }
                            },
                            child: Icon(
                              Icons.camera_alt_sharp,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100.spMax),
                  child: Image.file(
                    File(_image!),
                    fit: BoxFit.cover,
                  ),
                ),
        );
      },
    );
  }
}
