// ignore_for_file: file_names

import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/products_model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Models/profile_Model.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Bottom_Nav_View.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Cart_View.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Category_Details_View.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Category_View.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Favorite_View.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Home_View.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Product_Details_View.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Profile_View.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Change_Password_View.dart';
import 'package:e_commerce/Features/Registeration/Presentation/Views/Login_View.dart';
import 'package:e_commerce/Features/Registeration/Presentation/Views/Register_View.dart';
import 'package:e_commerce/Features/Starter/Presentation/Starter_View.dart';
import 'package:e_commerce/Features/Starter/Presentation/Splash_View.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splash = '/';
  static const String starter = '/starter';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String category = '/category';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String favorite = '/favorite';
  static const String product = '/product';
  static const String categoryDetails = '/categoryDetails';
  static const String bottomNav = '/bottomNav';
  static const String changePassword = '/changePassword';

  static final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: starter,
      builder: (context, state) => const StarterView(),
    ),
    GoRoute(
      path: login,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: register,
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: home,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: category,
      builder: (context, state) => const CategoryView(),
    ),
    GoRoute(
      path: cart,
      builder: (context, state) => const CartView(),
    ),
    GoRoute(
      path: favorite,
      builder: (context, state) => const FavoriteView(),
    ),
    GoRoute(
      path: bottomNav,
      builder: (context, state) => const BottomNavScreen(),
    ),
    GoRoute(
      path: product,
      builder: (context, state) => ProductDetailsView(
        item: state.extra as ProductsModel,
      ),
    ),
    GoRoute(
      path: categoryDetails,
      builder: (context, state) => const CategoryDetailsView(),
    ),
    GoRoute(
      path: changePassword,
      builder: (context, state) => const ChangePasswordView(),
    ),
    GoRoute(
      path: profile,
      builder: (context, state) => ProfileView(
        userData: state.extra as ProfileModel,
      ),
    ),
  ]);
}
