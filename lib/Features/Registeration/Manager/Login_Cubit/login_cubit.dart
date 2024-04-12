// ignore_for_file: avoid_print

import 'package:e_commerce/Core/Cache/cash_helper.dart';
import 'package:e_commerce/Core/Util/Helper/End_Point.dart';
import 'package:e_commerce/Features/Registeration/Data/Repositery/Regist_Repo.dart';
import 'package:e_commerce/Features/Registeration/Data/Repositery/Regist_Repo_Impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final RegistRepo repo = RegistRepoImpl();

  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  Future<void> login() async {
    emit(LoginLoading());
    final result = await repo.post(EndPoint.login, data: {
      ApiKey.email: signInEmail.text,
      ApiKey.password: signInPassword.text,
    });
    result.fold((failure) => emit(LoginFailure(failure.errorMessage)),
        (response) async {
      print('data : $response');
      if (response[ApiKey.status] == true) {
        // Save the token to cache
        token = response[ApiKey.data][ApiKey.token];
        await CacheHelper.saveData(key: ApiKey.token, value: token);
        print('token : $token');
        emit(LoginSuccess(response[ApiKey.message].toString()));
      } else {
        emit(LoginFailure(response[ApiKey.message].toString()));
      }
    });
  }
}
