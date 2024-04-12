import 'package:e_commerce/Core/Cache/cash_helper.dart';
import 'package:e_commerce/Core/Util/App_Router.dart';
import 'package:e_commerce/Core/Util/My_Bloc_Observer.dart';
import 'package:e_commerce/Core/Util/constant.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Cart_Cubit/cart_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Home_Cubit/home_cubit.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Manager/Profile_Cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()..getInitialData(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit()..getCart(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit()..profile(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            title: 'E-Commerce',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.hindSiliguriTextTheme(),
              primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                backgroundColor: const Color.fromARGB(
                  255,
                  121,
                  242,
                  240,
                ),
                foregroundColor: blue.withOpacity(0.5),
                centerTitle: true,
                titleTextStyle: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.bungeeSpice().fontFamily,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension HomeCubitExt on HomeCubit {
  Future<void> getInitialData() async {
    await Future.wait([
      getProducts(),
      getBannerData(),
      getCategories(),
      getFavorites(),
    ]);
  }
}
