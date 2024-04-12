// ignore_for_file: file_names

import 'package:e_commerce/Core/Util/App_Router.dart';
import 'package:e_commerce/Core/Util/Helper/Show_Message.dart';
import 'package:e_commerce/Features/Registeration/Manager/Login_Cubit/login_cubit.dart';
import 'package:e_commerce/Core/Shared/Custom_Button.dart';
import 'package:e_commerce/Core/Shared/Custom_TextField.dart';
import 'package:e_commerce/Features/Registeration/Presentation/Widgets/dont_have_an_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ShowMessage().showMessage(state.message, context, Colors.green);
          GoRouter.of(context).pushReplacement(AppRouter.bottomNav);
        }
        if (state is LoginFailure) {
          ShowMessage().showMessage(state.errorMessage, context, Colors.red);
        }
      },
      builder: (context, state) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0.w, top: 24.h),
                  child: IconButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                      )),
                ),
              ),
              SizedBox(
                width: width * .9,
                child: SingleChildScrollView(
                  child: Card(
                    surfaceTintColor: Colors.blue,
                    color: Colors.white,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: context.read<LoginCubit>().signInFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 30.sp, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: height * .03),
                            CustomInputField(
                              hintText: "Enter Your Email",
                              obscureText: false,
                              suffixIcon: false,
                              controller:
                                  context.read<LoginCubit>().signInEmail,
                            ),
                            CustomInputField(
                              hintText: "Enter Your Password",
                              obscureText: true,
                              suffixIcon: true,
                              controller:
                                  context.read<LoginCubit>().signInPassword,
                            ),
                            SizedBox(height: height * .05),
                            state is LoginLoading
                                ? Center(
                                    child:
                                        LoadingAnimationWidget.halfTriangleDot(
                                            color: Colors.green.shade200,
                                            size: 50))
                                : CustomButton(
                                    text: "Login",
                                    onPressed: () {
                                      if (context
                                          .read<LoginCubit>()
                                          .signInFormKey
                                          .currentState!
                                          .validate()) {
                                        context.read<LoginCubit>().login();
                                      }
                                    },
                                  ),
                            SizedBox(height: height * .03),
                            DontHaveAnAccountWidget(
                              size: Size(width, height),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
