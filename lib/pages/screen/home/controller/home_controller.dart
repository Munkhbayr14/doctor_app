import 'dart:developer';

import 'package:app/core/utils/token_preference.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  void tokenGet() async {
    var bearerToken = await TokenPreference.getToken();
    log("$bearerToken");
  }
}
