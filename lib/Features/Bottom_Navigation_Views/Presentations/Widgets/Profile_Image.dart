// ignore_for_file: file_names

import 'dart:io';

import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/profile_Model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Profile_Cubit/profile_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Items_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    super.key,
    required this.userModel,
  });

  final ProfileModel? userModel;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  String? _image;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileCubit>(context);

    return Stack(
      children: [
        _image == null
            ? SizedBox(
                height: MediaQuery.of(context).size.height * .24,
                width: MediaQuery.of(context).size.width * .4,
                child: ItemsImages(
                  imageUrl: widget.userModel!.image!,
                  borderRadius: 400,
                  fit: BoxFit.cover,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(400),
                child: Image.file(
                  File(_image!),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * .24,
                  width: MediaQuery.of(context).size.width * .4,
                ),
              ),
        Positioned.fromRect(
          rect: Rect.fromLTWH(120, 120, 32.w, 32.h),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.shade400,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: InkWell(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 80);
                if (image != null) {
                  setState(() {
                    _image = image.path;
                  });
                  cubit.profilePic = (File(_image!));
                }
              },
              child: const Icon(
                Icons.camera_alt_sharp,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
