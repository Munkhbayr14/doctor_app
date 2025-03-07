import 'dart:developer';

import 'package:app/core/api/dio_client.dart';
import 'package:app/core/utils/token_preference.dart';
import 'package:app/pages/screen/layout/bottom_navigation_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var lastnameController = TextEditingController();
  var firstnameController = TextEditingController();

  var isEmailValid = true.obs;
  var isPasswordValid = true.obs;
  var isConfirmPasswordValid = true.obs;
  var isLastNameValid = true.obs;
  var isFirstNameValid = true.obs;
  var isLoading = false.obs;
  var data = [].obs;
  final Dio dio = DioClient().getInstance();
  Future<void> saveToken(String token) async {
    await TokenPreference.setToken(token);
  }

  void login() async {
    if (validateInputs(emailController.text, passwordController.text)) {
      isLoading.value = true;
      try {
        var response = await dio.post(
          "auth/login",
          data: {
            "email": emailController.text,
            'password': passwordController.text
          },
        );
        log("Response data: ${response.data}");
        if (response.statusCode! >= 200 && response.statusCode! <= 299) {
          String token = response.data['accessToken'];
          log("toooookkkkkeeennn ===== > ${response.data['accessToken']}");
          await saveToken(token);
          Get.snackbar(
            "Амжилттай",
            "${response.data['message']}",
            colorText: Colors.white,
            backgroundColor: Colors.green,
          );

          Get.off(() => BottomNavigationScreen());
          emailController.clear();
          passwordController.clear();
        } else {
          Get.snackbar(
            'Алдаа',
            "${response.data['message'] ?? response.statusMessage}",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } catch (e) {
        if (e is DioException) {
          log("Error during login: $e");
          Get.snackbar(
            'Алдаа',
            e.response?.data['message'] ?? "Сервертэй холбогдоход алдаа гарлаа",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        } else {
          log("Unexpected Error: $e");
          Get.snackbar(
            'Алдаа',
            "Тодорхойгүй алдаа гарлаа: $e",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar(
        'Алдаа',
        "Буруу мэдээлэл оруулсан байна",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  void signup() async {
    String confirmPassword = confirmPasswordController.text.trim();

    if (validateInputs(emailController.text, passwordController.text) &&
        validateConfirmPassword(passwordController.text, confirmPassword) &&
        validateName(firstnameController.text, lastnameController.text)) {
      try {
        var response = await dio.post("auth/signup", data: {
          "email": emailController.text,
          "password": passwordController.text,
          "confirmationPassword": confirmPasswordController.text,
          "firstname": firstnameController.text,
          "lastname": lastnameController.text,
          "role": "USER",
        });
        if (response.statusCode! >= 200 && response.statusCode! <= 299) {
          Get.snackbar(
            "Амжилттай",
            "${response.data['message']}",
            colorText: Colors.white,
            backgroundColor: Colors.green,
          );
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          lastnameController.clear();
          firstnameController.clear();
        } else {
          Get.snackbar(
            'Алдаа',
            "${response.data['message'] ?? response.statusMessage}",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } catch (e) {
        if (e is DioException) {
          log("Error during login: $e");
          Get.snackbar(
            'Алдаа',
            "${e.response!.data['message'] ?? e.response!.statusMessage}",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      }
    } else {
      Get.snackbar(
        'Алдаа',
        "Буруу мэдээлэл оруулсан байна",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  bool validateInputs(String email, String password) {
    email = email.trim();
    password = password.trim();

    isEmailValid.value = email.isNotEmpty && email.isEmail;
    isPasswordValid.value = password.isNotEmpty && password.length >= 6;

    return isEmailValid.value && isPasswordValid.value;
  }

  bool validateConfirmPassword(String password, String confirmPassword) {
    isConfirmPasswordValid.value = password == confirmPassword;
    return isConfirmPasswordValid.value;
  }

  bool validateName(String firstName, String lastName) {
    firstName = firstName.trim();
    lastName = lastName.trim();
    isFirstNameValid.value = firstName.isNotEmpty;
    isLastNameValid.value = lastName.isNotEmpty;

    return isFirstNameValid.value && isLastNameValid.value;
  }
}
