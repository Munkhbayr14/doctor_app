import 'dart:io';
import 'dart:developer';
import 'package:app/core/api/dio_client.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart' as form;
import 'package:get/get_connect/http/src/multipart/multipart_file.dart'
    as multi;
import 'package:app/core/utils/token_preference.dart';
import 'package:app/pages/auth/view/login_screen.dart';
import 'package:app/pages/screen/profile/model/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:path/path.dart' as path;

class ProfileController extends GetxController {
  final Dio dio = DioClient().getInstance();
  String bearerToken = "";
  var profileModel = Rxn<Result>();
  TextEditingController firstNameController = TextEditingController();
  RxInt userId = 0.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  RxBool isUploading = false.obs;
  final picker = ImagePicker();
  var isLoading = false.obs;

  void onInit() {
    bearerToken = TokenPreference.getToken()!;
    var decodedToken = JwtDecoder.decode(bearerToken);
    userId.value = decodedToken['userId'];
    fetchProfileData();
    super.onInit();
  }

  void logOut() async {
    TokenPreference.setToken("");
    Get.offAll(() => LoginScreen());
  }

  Future<void> fetchProfileData() async {
    try {
      isLoading.value = true;
      var response = await dio.get(
        "profile/${userId.value}",
        options: Options(
          headers: {"Authorization": "Bearer $bearerToken"},
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var profileData = ProfileModel.fromJson(response.data);
        profileModel.value = profileData.result;
      } else {
        print('Logout failed');
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfileData(
    String lastName,
    String firstName,
    String email,
  ) async {
    try {
      // form.FormData formData = form.FormData.fromMap({
      //   "lastname": lastName,
      //   "firstname": firstName,
      //   "email": email,
      //   "avatarUrl": await multi.MultipartFile.fromFile(
      //     selectedImage.value!.path,
      //     filename: path.basename(selectedImage.value!.path),
      //   ),
      // });
      var avatarUrl = path.basename(selectedImage.value!.path);
      log("==>${avatarUrl}");
      var response = await dio.patch(
        "profile/${userId.value}",
        data: {
          "lastname": lastName,
          "firstname": firstName,
          "email": email,
          "avatarUrl": avatarUrl,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $bearerToken",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      log("Response: ${response.data}");

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var profileData = ProfileModel.fromJson(response.data);
        profileModel.value = profileData.result;
        fetchProfileData();
        Get.snackbar(
          "Амжилттай",
          "${response.data['message']}",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        Get.back();
      } else {
        Get.snackbar(
          'Алдаа',
          "${response.data['message'] ?? response.statusMessage}",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      log("Error uploading profile: $e");
      Get.snackbar(
        'Алдаа',
        "Профайл шинэчлэхэд алдаа гарлаа",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }
}
