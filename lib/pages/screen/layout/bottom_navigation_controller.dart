import 'package:app/pages/screen/chart/chart_screen.dart';
import 'package:app/pages/screen/home/view/home_screen.dart';
import 'package:app/pages/screen/info/view/info_screen.dart';
import 'package:app/pages/screen/profile/view/profile_screen.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 0.obs;

  final screens = [
    HomeScreen(),
    InfoScreen(),
    ChartScreen(),
    ProfileScreen(),
  ];

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
