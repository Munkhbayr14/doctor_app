import 'dart:developer';
import 'package:app/pages/screen/home/controller/home_controller.dart';
import 'package:app/pages/screen/home/model/banner_model.dart';
import 'package:app/pages/screen/home/view/infoWidget/info_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  BannerModel? bannerData;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Доктор",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.grey[800]),
                  ),
                  IconButton(
                    onPressed: () {
                      print("Notification clicked!"); // Түр үйлдэл
                    },
                    icon: Icon(Icons.notifications, color: Colors.black87),
                  )
                ],
              ),
              Obx(() {
                if (homeController.bannerList.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CarouselSlider.builder(
                        itemCount: homeController.bannerList.length,
                        options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            homeController.currentIndex.value = index;
                          },
                        ),
                        itemBuilder: (context, index, realIdx) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                    homeController.bannerList[index].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                          height: 10), // ✅ DotsIndicator-тэй зай гаргах
                      Obx(() => DotsIndicator(
                            dotsCount: homeController.bannerList.length,
                            position:
                                homeController.currentIndex.value.toDouble(),
                            decorator: DotsDecorator(
                              activeColor:
                                  Colors.blue, // ✅ Идэвхтэй цэгийн өнгө
                              size: const Size.square(8.0),
                              activeSize: const Size(18.0, 8.0),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          )),
                    ],
                  );
                }
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Мэдээ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'Бүгд',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InfoWidget(),
                      InfoWidget(),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
