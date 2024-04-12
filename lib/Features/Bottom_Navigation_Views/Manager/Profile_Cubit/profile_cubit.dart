// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:e_commerce/Core/Cache/cash_helper.dart';
import 'package:e_commerce/Core/Util/App_Router.dart';
import 'package:e_commerce/Core/Util/Helper/End_Point.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/profile_Model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Repository/repo.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Repository/repo_Impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final Repo repo = RepoImpl();
  static ProfileCubit get(context) => BlocProvider.of<ProfileCubit>(context);
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  File? profilePic;
  // get profile
  ProfileModel? dataModel;
  Future<void> profile() async {
    emit(ProfileLoading());

    final response = await repo.get(EndPoint.profile);
    response.fold((failure) => emit(ProfileFailure(failure.errorMessage)),
        (response) {
      if (response[ApiKey.status] == true) {
        dataModel = ProfileModel.fromJson(response[ApiKey.data]);
        emit(ProfileSuccess(dataModel!));
      } else {
        emit(ProfileFailure(response[ApiKey.message].toString()));
      }
    });
  }

  // logOut
  Future<void> logOut({
    required BuildContext context,
  }) async {
    emit(LogOutLoading());

    final response = await repo.post(
      EndPoint.logout,
      data: {
        ApiKey.fcmToken: token,
      },
    );
    response.fold((failure) => emit(LogOutFailure(failure.errorMessage)),
        (response) async {
      if (response[ApiKey.status] == true) {
        await CacheHelper.removeData(key: ApiKey.token).then((value) {
          if (value) {
            GoRouter.of(context).pushReplacement(AppRouter.starter);
          }
        });
        emit(LogOutSuccess(response[ApiKey.message].toString()));
      } else {
        emit(LogOutFailure(response[ApiKey.message].toString()));
      }
    });
  }

// update profile
  Future<void> updateProfileData(ProfileModel userData) async {
    emit(UpdateProfileLoading());
    final response = await repo.put(
      EndPoint.updateProfile,
      data: {
        ApiKey.name: userData.name,
        ApiKey.email: userData.email,
        ApiKey.phone: userData.phone,
        ApiKey.image: profilePic == null
            ? userData.image
            : await profileImageData(profilePic!),
      },
    );
    response.fold((failure) => emit(UpdateProfileFailure(failure.errorMessage)),
        (response) async {
      if (response[ApiKey.status] == true) {
        await profile();
        emit(UpdateProfileSuccess(response[ApiKey.message].toString()));
      } else {
        emit(UpdateProfileFailure(response[ApiKey.message].toString()));
      }
    });
  }

  Future<String?> profileImageData(File image) async {
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

  // change password
  Future<void> changePassword() async {
    emit(ChangePasswordLoading());
    final response = await repo.post(EndPoint.changePassword, data: {
      ApiKey.currentPassword: oldPassword.text,
      ApiKey.newPassword: newPassword.text,
    });
    response
        .fold((failure) => emit(ChangePasswordFailure(failure.errorMessage)),
            (response) {
      if (response[ApiKey.status] == true) {
        emit(ChangePasswordSuccess(response[ApiKey.message].toString()));
      } else {
        emit(ChangePasswordFailure(response[ApiKey.message].toString()));
      }
    });
  }
}
