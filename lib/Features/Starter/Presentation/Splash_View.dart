// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'dart:developer';

import 'package:e_commerce/Core/Cache/cash_helper.dart';
import 'package:e_commerce/Core/Util/App_Router.dart';
import 'package:e_commerce/Core/Util/Helper/End_Point.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// SplashView
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final duration = const Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(duration);
    // Retrieve the token from SharedPreferences
    token = await CacheHelper.getData(key: ApiKey.token);
    // Check if the token is null or empty
    if (token == null || token!.isEmpty) {
      log('Token is null or empty');
      // Navigate to the login screen
      GoRouter.of(context).pushReplacement(AppRouter.starter);
    } else {
      print('token : $token');
      // Navigate to the home screen
      GoRouter.of(context).pushReplacement(AppRouter.bottomNav);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/logo.jpg"),
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Developed By Mohamed Ebrahim',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
