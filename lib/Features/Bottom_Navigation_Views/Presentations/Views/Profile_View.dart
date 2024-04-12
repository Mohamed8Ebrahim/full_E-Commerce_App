// ignore_for_file: file_names

import 'package:e_commerce/Core/Shared/Custom_Button.dart';
import 'package:e_commerce/Core/Shared/Custom_TextField.dart';
import 'package:e_commerce/Core/Util/Helper/Show_Message.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/profile_Model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Profile_Cubit/profile_cubit.dart';
import 'package:e_commerce/Core/Shared/Views_Background.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Widgets/Profile_Header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.userData});

  final ProfileModel userData;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController email;
  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.userData.name);
    phone = TextEditingController(text: widget.userData.phone);
    email = TextEditingController(text: widget.userData.email);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      body: ViewsBackground(
        child: Center(
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is UpdateProfileSuccess) {
                ShowMessage().showMessage(state.message, context, Colors.green);
              } else if (state is UpdateProfileFailure) {
                ShowMessage()
                    .showMessage(state.errorMessage, context, Colors.red);
              }
            },
            builder: (context, state) {
              return Form(
                key: cubit.formKey,
                child: CustomScrollView(slivers: [
                  ProfileHeader(widget: widget),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Gap(24.h),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(children: [
                            CustomInputField(
                              hintText: 'Enter your Name',
                              controller: name,
                              color: Colors.orange.shade100,
                              prefixIcon: const Icon(Icons.edit),
                              onChanged: (value) {
                                name.text = value;
                              },
                            ),
                            CustomInputField(
                              hintText: 'Enter your Email',
                              controller: email,
                              color: Colors.orange.shade200,
                              enabled: false,
                            ),
                            CustomInputField(
                              hintText: 'Enter your Phone Number',
                              controller: phone,
                              obscureText: false,
                              color: Colors.yellow.shade200,
                              prefixIcon: const Icon(Icons.edit),
                              suffixIcon: false,
                              onChanged: (value) {
                                phone.text = value;
                              },
                            ),
                            const Gap(24),
                            state is UpdateProfileLoading
                                ? Center(
                                    child:
                                        LoadingAnimationWidget.halfTriangleDot(
                                            color: Colors.green.shade100,
                                            size: 50))
                                : CustomButton(
                                    text: 'Update',
                                    onPressed: () {
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.formKey.currentState!.save();
                                        widget.userData.name = name.text;
                                        widget.userData.phone = phone.text;
                                        cubit
                                            .updateProfileData(widget.userData);
                                      }
                                    },
                                  ),
                          ]),
                        )
                      ],
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
