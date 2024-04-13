// ignore_for_file: file_names

class EndPoint {
  static String baseUrl = "https://student.valuxapps.com/api/";

  static String login = "login";

  static String register = "register";

  static String profile = "profile";

  static String logout = "logout";

  static String banners = "banners";

  static String categories = "categories";

  static String home = "home";

  static String favorites = "favorites";

  static String products = "products";

  static String carts = "carts";

  static String updateProfile = "update-profile";

  static String changePassword = "change-password";
}

class ApiKey {
  static String status = "status";
  static String message = "message";
  static String data = "data";
  static String token = "token";
  static String fcmToken = "fcm_token";
  static String id = "id";

  static String name = "name";
  static String email = "email";
  static String phone = "phone";
  static String password = "password";
  static String image = "image";
  static String products = "products";
  static String currentPassword = "current_password";
  static String newPassword = "new_password";
}

String? token;
String? recentToken = '';
