import 'package:app/core/api/dio_client.dart';
import 'package:app/core/utils/token_preference.dart';
import 'package:app/pages/screen/home/model/banner_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class HomeController extends GetxController {
  final Dio dio = DioClient().getInstance();
  var bannerList = <Result>[].obs;
  var currentIndex = 0.obs;
  String bearerToken = "";
  var isLoading = false.obs;
  var isLiked = false.obs;
  var isCommented = false.obs;

  @override
  void onInit() {
    bearerToken = TokenPreference.getToken()!;
    super.onInit();
    getBanner();
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }

  void toggleComment() {
    isCommented.value = !isCommented.value;
  }

  Future<void> getBanner() async {
    try {
      isLoading.value = true;
      var response = await dio.get("banner/all");
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var bannerModel = BannerModel.fromJson(response.data);
        bannerList.value = bannerModel.result;
      }
    } catch (e) {
      print("Error fetching banners: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
