// ignore_for_file: file_names

import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Home_Cubit/home_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Banner_Part.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Category_Part.dart';
import 'package:e_commerce/Core/Shared/Views_Background.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Drawer_Menue.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Products_Part.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Search_TextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: const DrawerMenue(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ViewsBackground(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(8.spMax),
              child: Column(
                children: [
                  SearchTextField(
                    onChanged: (value) {
                      BlocProvider.of<HomeCubit>(context)
                          .filterProducts(input1: value);
                    },
                  ),
                  const BannerPart(),
                  Gap(10.h),
                  const CategoryPart(),
                  Gap(10.h),
                  const ProductsPart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
