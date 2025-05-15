import 'package:app/pages/screen/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoWidget extends StatelessWidget {
  final HomeController infoController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(10),
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // Image Container
          Container(
            height: size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage("assets/banner/aaaa.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(() {
                    return IconButton(
                      onPressed: infoController.toggleLike,
                      icon: Icon(
                        infoController.isLiked.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: infoController.isLiked.value
                            ? Colors.red
                            : Colors.black,
                      ),
                    );
                  }),
                  Text(
                    "1",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: infoController.toggleComment,
                    icon: Icon(
                      Icons.mode_comment_outlined,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "10",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
