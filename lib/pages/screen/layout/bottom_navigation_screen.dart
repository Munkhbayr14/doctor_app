import 'package:app/core/utils/colors.dart';
import 'package:app/core/utils/system_icons_icons.dart';
import 'package:app/pages/screen/layout/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationController bottomNavController =
      Get.put(BottomNavigationController());
  double bottomNavBarHeight = 80;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        body:
            bottomNavController.screens[bottomNavController.currentIndex.value],
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          width: size.width,
          height: bottomNavBarHeight,
          child: Stack(
            children: [
              // CustomPaint(
              //   size: Size(size.width, bottomNavBarHeight),
              // ),
              // Center(
              //   heightFactor: 0.5,
              //   child: FloatingActionButton(
              //     onPressed: () {
              //       // showModalBottomSheet(
              //       //   context: context,
              //       //   builder: (BuildContext context) {
              //       //     return SimpleMenuDialog();
              //       //   },
              //       // );
              //     },
              //     backgroundColor: Colors.blue[900],
              //     elevation: 0.1,
              //     child: const Icon(Icons.add),
              //   ),
              // ),
              SizedBox(
                width: size.width,
                height: bottomNavBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        bottomNavController.changeTab(0);
                      },
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          bottomNavController.currentIndex.value == 0
                              ? Image.asset(
                                  'assets/img/bottom_gif/home.gif',
                                  height: 25,
                                  color: AppColors.textcolor,
                                )
                              : const Icon(
                                  SystemIcons.home_1,
                                  size: 18,
                                ),
                          Text(
                            'Нүүр',
                            style: TextStyle(
                                color:
                                    bottomNavController.currentIndex.value == 0
                                        ? AppColors.textcolor
                                        : AppColors.dark400),
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     bottomNavController.changeTab(1);
                    //   },
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       bottomNavController.currentIndex.value == 1
                    //           ? Image.asset(
                    //               'assets/img/bottom_gif/wallet.gif',
                    //               height: 20,
                    //             )
                    //           : const Icon(
                    //               Icons.wallet,
                    //               size: 16,
                    //             ),
                    //       Text(
                    //         'Хэтэвч',
                    //         style: TextStyle(
                    //             color:
                    //                 bottomNavController.currentIndex.value == 1
                    //                     ? AppColors.primary400
                    //                     : AppColors.dark400),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(width: size.width * 0.15),
                    InkWell(
                      onTap: () {
                        bottomNavController.changeTab(1);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          bottomNavController.currentIndex.value == 1
                              ? Image.asset(
                                  'assets/img/bottom_gif/category.gif',
                                  height: 25,
                                  color: AppColors.textcolor,
                                )
                              : const Icon(
                                  SystemIcons.services,
                                  size: 18,
                                ),
                          Text(
                            'Ая',
                            style: TextStyle(
                                color:
                                    bottomNavController.currentIndex.value == 1
                                        ? AppColors.textcolor
                                        : AppColors.dark400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
