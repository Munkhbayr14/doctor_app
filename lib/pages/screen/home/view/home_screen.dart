import 'package:app/core/utils/colors.dart';
import 'package:app/pages/screen/home/controller/home_controller.dart';
import 'package:app/pages/screen/home/view/infoWidget/info_widget.dart';
import 'package:app/pages/screen/profile/controller/profile_controller.dart';
import 'package:app/pages/screen/profile/view/profile_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Obx(() {
          return homeController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) => ProfileScreen(),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(20)),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.textcolor),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                            image: profileController
                                                        .profileModel
                                                        .value
                                                        ?.avatarUrl
                                                        ?.isNotEmpty ==
                                                    true
                                                ? NetworkImage(profileController
                                                    .profileModel
                                                    .value!
                                                    .avatarUrl!)
                                                : const AssetImage(
                                                        'assets/img/avatar/Profile default.png')
                                                    as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.textcolor),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Color(0xFFF0EDFF)),
                                      child: Text(
                                        profileController.profileModel.value
                                                ?.firstName ??
                                            "No Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.height * 0.02,
                                            color: Colors.grey[800]),
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                  onPressed: () =>
                                      print("Notification clicked!"),
                                  icon: Icon(Icons.notifications,
                                      color: Colors.black87),
                                )
                              ],
                            )),
                      ),
                      Expanded(
                          child: RefreshIndicator(
                        onRefresh: () async {
                          await homeController.getBanner();
                          await profileController.fetchProfileData();
                        },
                        child: ListView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(right: 16, left: 16),
                          children: [
                            SizedBox(height: 15),
                            Obx(() {
                              return Column(
                                children: [
                                  CarouselSlider.builder(
                                    itemCount: homeController.bannerList.length,
                                    options: CarouselOptions(
                                      viewportFraction: 1,
                                      autoPlay: true,
                                      aspectRatio: 2.0,
                                      enlargeCenterPage: true,
                                      onPageChanged: (index, reason) {
                                        homeController.currentIndex.value =
                                            index;
                                      },
                                    ),
                                    itemBuilder: (context, index, realIdx) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(homeController
                                              .bannerList[index].image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Obx(() => DotsIndicator(
                                        dotsCount:
                                            homeController.bannerList.length,
                                        position: homeController
                                            .currentIndex.value
                                            .toDouble(),
                                        decorator: DotsDecorator(
                                          color: Color(0xFFD9D9D9),
                                          activeColor: AppColors.textcolor,
                                          size: const Size.square(8.0),
                                          activeSize: const Size(8.0, 8.0),
                                          activeShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),
                                      )),
                                ],
                              );
                            }),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Story',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                InfoWidget(),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      )),
                    ],
                  ),
                );
        }));
  }
}
