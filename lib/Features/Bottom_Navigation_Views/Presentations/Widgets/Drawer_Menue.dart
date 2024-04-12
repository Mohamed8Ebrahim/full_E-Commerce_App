// ignore_for_file: file_names

import 'package:e_commerce/Core/Util/App_Router.dart';
import 'package:e_commerce/Core/Util/Helper/Show_Message.dart';
import 'package:e_commerce/Core/Util/constant.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/profile_Model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Profile_Cubit/profile_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/AppBar_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DrawerMenue extends StatelessWidget {
  const DrawerMenue({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    ProfileModel? data = ProfileCubit.get(context).dataModel;
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileSuccess) {
                data = state.dataModel;
              } else if (state is LogOutSuccess) {
                ShowMessage().showCherryToastSuccess(state.message, context);
              } else if (state is ProfileFailure) {
                ShowMessage()
                    .showMessage(state.errorMessage, context, Colors.red);
              } else if (state is LogOutFailure) {
                ShowMessage()
                    .showMessage(state.errorMessage, context, Colors.red);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  AppBarDrawer(data: data, state: state),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Wrap(
                      runSpacing: -5.h,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.home),
                          title: const Text('Home'),
                          onTap: () {
                            GoRouter.of(context).pop();
                          },
                        ), // List Tile
                        ListTile(
                          leading: const Icon(Icons.password),
                          title: const Text('Change Password'),
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.changePassword);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.account_circle),
                          title: const Text('Profile'),
                          onTap: () {
                            GoRouter.of(context)
                                .push(AppRouter.profile, extra: data);
                          },
                        ),
                        ListTile(
                          leading: state is LogOutLoading
                              ? Icon(Icons.exit_to_app,
                                  color: green, size: 20.sp)
                              : const Icon(Icons.exit_to_app),
                          title: state is LogOutLoading
                              ? Text(
                                  'Logout...',
                                  style: TextStyle(
                                      color: green,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                )
                              : const Text('Logout'),
                          onTap: () async {
                            await ProfileCubit.get(context)
                                .logOut(context: context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Developed by mohamed Ebrahim@2024",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
