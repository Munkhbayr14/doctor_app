import 'package:app/pages/screen/chart/chart_screen.dart';
import 'package:app/pages/screen/home/view/home_screen.dart';
import 'package:app/pages/screen/music/view/music_screen.dart';
import 'package:app/pages/screen/profile/view/profile_screen.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 0.obs;

  final screens = [
    HomeScreen(),
    MusicScreen(),
  ];

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
