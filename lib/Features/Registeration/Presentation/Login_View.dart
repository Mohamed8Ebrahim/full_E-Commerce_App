// ignore_for_file: file_names

import 'package:e_commerce/Core/Shared/Views_Background.dart';
import 'package:e_commerce/Features/Registeration/Manager/Login_Cubit/login_cubit.dart';
import 'package:e_commerce/Features/Registeration/Presentation/Widgets/Login_View_Body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const Scaffold(
        body: RegisterationBackground(
          child: LoginViewBody(),
        ),
      ),
    );
  }
}
