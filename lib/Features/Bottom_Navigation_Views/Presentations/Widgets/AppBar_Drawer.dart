// ignore_for_file: file_names

import 'package:e_commerce/Core/Util/Helper/Loading.dart';
import 'package:e_commerce/Core/Util/constant.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/profile_Model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Profile_Cubit/profile_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Items_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarDrawer extends StatelessWidget {
  const AppBarDrawer({
    super.key,
    required this.data,
    required this.state,
  });
  final ProfileState state;
  final ProfileModel? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'asset/prof_back.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: state is ProfileLoading
          ? Loading(size: 30.r)
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: ItemsImages(
                        imageUrl: data?.image ?? '',
                        borderRadius: 1000,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(data?.name ?? '',
                        style: const TextStyle(
                            color: greenLight,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text(data?.email ?? '',
                        style: const TextStyle(fontSize: 15, color: white)),
                  ]),
            ),
    );
  }
}
