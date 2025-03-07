import 'dart:developer';

import 'package:app/core/api/dio_client.dart';
import 'package:app/core/utils/token_preference.dart';
import 'package:app/pages/auth/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Dio dio = DioClient().getInstance();
  String bearerToken = "";
  void onInit() {
    bearerToken = TokenPreference.getToken()!;
    super.onInit();
    log("token======: $bearerToken");
  }

  void logout() async {
    // var response = await dio.post("auth/logout",
    //     options: Options(headers: {"Authorization": "Bearer $bearerToken"}));
    // if (response.statusCode == 200) {
    //   log("${response.statusCode}");
    TokenPreference.setToken("");
    Get.off(() => LoginScreen());
    // } else {
    //   print('Logout failed');
    // }
  }
}
