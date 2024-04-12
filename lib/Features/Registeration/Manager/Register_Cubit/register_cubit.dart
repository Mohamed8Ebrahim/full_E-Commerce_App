// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:e_commerce/Core/Cache/cash_helper.dart';
import 'package:e_commerce/Core/Util/Helper/End_Point.dart';
import 'package:e_commerce/Features/Registeration/Data/Repositery/Regist_Repo.dart';
import 'package:e_commerce/Features/Registeration/Data/Repositery/Regist_Repo_Impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final RegistRepo repo = RegistRepoImpl();

  GlobalKey<FormState> signUpFormKey = GlobalKey();
  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpPhoneNumber = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  File? profilePic;

  Future<void> register() async {
    emit(RegisterLoading());
    var uploadedImage = await updateprofilePicture(profilePic ?? File(''));
    final result = await repo.post(EndPoint.register, data: {
      ApiKey.name: signUpName.text,
      ApiKey.email: signUpEmail.text,
      ApiKey.phone: signUpPhoneNumber.text,
      ApiKey.password: signUpPassword.text,
      ApiKey.image: uploadedImage,
    });
    result.fold((failure) => emit(RegisterFailure(failure.errorMessage)),
        (response) async {
      print('data : $result');
      if (response[ApiKey.status] == true) {
        // Save the token to cache
        token = response[ApiKey.data][ApiKey.token];
        await CacheHelper.saveData(key: ApiKey.token, value: token);
        emit(RegisterSuccess(response[ApiKey.message].toString()));
      } else {
        emit(RegisterFailure(response[ApiKey.message].toString()));
      }
    });
  }

  Future<String?> updateprofilePicture(File image) async {
    try {
      // Read the file as bytes
      List<int> imageBytes = await image.readAsBytes();

      // Encode the bytes as a base64 string
      String base64Image = base64Encode(imageBytes);

      // Return the base64 string
      return base64Image;
    } catch (e) {
      // Handle exceptions
      print('Error encoding image: $e');
      return null;
    }
  }
}
