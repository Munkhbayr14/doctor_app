import 'package:app/pages/screen/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
          child: TextButton(
              onPressed: homeController.tokenGet,
              child: Text("have a token in the homeScreen?")),
        )));
  }
}
