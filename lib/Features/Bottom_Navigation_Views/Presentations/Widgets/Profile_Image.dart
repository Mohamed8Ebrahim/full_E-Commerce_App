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
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width * .4,
                child: ItemsImages(
                  imageUrl: widget.userModel?.image ?? '',
                  borderRadius: 200,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.file(
                  File(_image!),
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.width * .4,
                ),
              ),
        Positioned.fromRect(
          rect: Rect.fromLTWH(115, 115, 30.w, 30.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(30),
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
