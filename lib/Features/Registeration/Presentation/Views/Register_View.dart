// ignore_for_file: file_names

import 'package:e_commerce/Core/Shared/Views_Background.dart';
import 'package:e_commerce/Features/Registeration/Manager/Register_Cubit/register_cubit.dart';
import 'package:e_commerce/Features/Registeration/Presentation/Widgets/Register_View_Body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: const Scaffold(
        body: RegisterationBackground(
          child: RegisterViewBody(),
        ),
      ),
    );
  }
}
