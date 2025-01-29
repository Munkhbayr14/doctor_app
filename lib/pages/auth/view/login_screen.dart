import 'package:app/pages/auth/controller/auth_controller.dart';
import 'package:app/pages/auth/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
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
                'Нэвтрэх',
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
              Obx(() => TextFormField(
                    controller: authController.passwordController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFF493AD5),
                        ),
                        labelText: 'Нууц үг',
                        labelStyle: TextStyle(color: Color(0xFF493AD5)),
                        errorText: authController.isEmailValid.value
                            ? null
                            : "6-аас их тэмдэгт оруулах ёстой ",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none)),
                    obscureText: true,
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => authController.login(),
                child: Text(
                  'Нэвтрэх',
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
                  onPressed: () => Get.to(() => SignupScreen()),
                  child: Text('Бүртгэлгүй байна уу? Бүртгүүлэх',
                      style: TextStyle(color: Color(0xFF493AD5), fontSize: 16)))
            ],
          ),
        ),
      ),
    );
  }
}
