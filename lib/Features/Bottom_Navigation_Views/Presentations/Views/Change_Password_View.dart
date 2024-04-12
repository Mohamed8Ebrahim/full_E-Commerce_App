// ignore_for_file: file_names

import 'package:e_commerce/Core/Shared/Custom_Button.dart';
import 'package:e_commerce/Core/Util/Helper/Show_Message.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Profile_Cubit/profile_cubit.dart';
import 'package:e_commerce/Core/Shared/Views_Background.dart';
import 'package:e_commerce/Core/Shared/Custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: ViewsBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is ChangePasswordSuccess) {
                    Navigator.pop(context);
                    cubit.formKey.currentState!.reset();
                    cubit.oldPassword.clear();
                    cubit.newPassword.clear();
                    ShowMessage()
                        .showMessage(state.message, context, Colors.green);
                  } else if (state is ChangePasswordFailure) {
                    ShowMessage()
                        .showMessage(state.errorMessage, context, Colors.red);
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        CustomInputField(
                          hintText: 'Enter your Current Password',
                          controller: cubit.oldPassword,
                          color: Colors.orange.shade100,
                        ),
                        const Gap(10),
                        CustomInputField(
                          hintText: 'Enter your New Password',
                          controller: cubit.newPassword,
                          color: Colors.yellow.shade200,
                        ),
                        const Gap(24),
                        state is ChangePasswordLoading
                            ? Center(
                                child: LoadingAnimationWidget.halfTriangleDot(
                                    color: Colors.green.shade100, size: 50))
                            : CustomButton(
                                text: 'Update',
                                onPressed: () {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.changePassword();
                                  }
                                },
                              )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
