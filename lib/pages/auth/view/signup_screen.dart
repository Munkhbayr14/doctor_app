import 'package:app/pages/auth/controller/auth_controller.dart';
import 'package:app/pages/auth/view/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5f5f5),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Бүртгэл',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF493AD5),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Obx(() => TextField(
                    controller: authController.emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xFF493AD5),
                        ),
                        labelText: 'И-Мэйл',
                        labelStyle: TextStyle(color: Color(0xFF493AD5)),
                        errorText: authController.isEmailValid.value
                            ? null
                            : "И-Мэйл Хаягаа оруулна уу ",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none)),
                    keyboardType: TextInputType.emailAddress,
                  )),
              SizedBox(height: 20),
              Obx(() => TextField(
                    controller: authController.lastnameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xFF493AD5),
                      ),
                      labelText: 'Овог',
                      labelStyle: TextStyle(color: Color(0xFF493AD5)),
                      errorText: authController.isLastNameValid.value
                          ? null
                          : "Овог нэрээ оруулна уу",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none),
                    ),
                  )),
              SizedBox(height: 20),
              Obx(() => TextField(
                    controller: authController.firstnameController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xFF493AD5),
                        ),
                        labelText: 'Нэр',
                        labelStyle: TextStyle(color: Color(0xFF493AD5)),
                        errorText: authController.isFirstNameValid.value
                            ? null
                            : "Нэрээ оруулна уу  ",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none)),

                    // keyboardType: TextInputType.emailAddress,
                  )),
              SizedBox(height: 20),
              Obx(() => TextField(
                  controller: authController.passwordController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xFF493AD5),
                      ),
                      labelText: 'Нууц үг',
                      labelStyle: TextStyle(color: Color(0xFF493AD5)),
                      errorText: authController.isPasswordValid.value
                          ? null
                          : "6-аас их тэмдэгт оруулах ёстой",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none)),
                  obscureText: true)),
              SizedBox(height: 20),
              Obx(() => TextField(
                  controller: authController.confirmPasswordController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xFF493AD5),
                      ),
                      labelText: 'Нууц үг давтах',
                      labelStyle: TextStyle(color: Color(0xFF493AD5)),
                      errorText: authController.isConfirmPasswordValid.value
                          ? null
                          : "Нууц үг таарахгүй байна ",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none)),
                  obscureText: true)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => authController.signup(),
                child: Text(
                  'Бүртгэх',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF493AD5),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () => Get.to(() => LoginScreen()),
                  child: Text('Бүртгэлтэй байна уу? Нэвтрэх',
                      style: TextStyle(color: Color(0xFF493AD5), fontSize: 16)))
            ],
          ),
        ),
      ),
    );
  }
}
