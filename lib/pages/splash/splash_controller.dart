import 'dart:developer';

import 'package:app/core/utils/token_preference.dart';
import 'package:app/pages/auth/view/login_screen.dart';
import 'package:app/pages/screen/layout/bottom_navigation_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  String? bearerToken;
  @override
  void onInit() async {
    super.onInit();
    // SharedPreferences -г эхлүүлэх
    await TokenPreference.init();

    var bearerToken = await TokenPreference.getToken();
    log("token => $bearerToken");

    await Future.delayed(const Duration(milliseconds: 3000));
    if (bearerToken != null && bearerToken!.isNotEmpty) {
      Get.off(() => BottomNavigationScreen());
    } else {
      Get.off(() => LoginScreen());
    }
  }
}
