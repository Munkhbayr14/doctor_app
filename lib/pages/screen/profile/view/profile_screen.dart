import 'package:app/core/utils/colors.dart';
import 'package:app/pages/screen/profile/controller/profile_controller.dart';
import 'package:app/pages/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    lastNameController.text =
        profileController.profileModel.value?.lastName ?? "";
    firstNameController.text =
        profileController.profileModel.value?.firstName ?? "";
    emailController.text = profileController.profileModel.value?.email ?? "";

    return Obx(() {
      return profileController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Профайл",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    return GestureDetector(
                      onTap: profileController.pickImage,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.textcolor),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: profileController
                                          .selectedImage.value !=
                                      null
                                  ? FileImage(
                                      profileController.selectedImage.value!)
                                  : (profileController.profileModel.value
                                                  ?.avatarUrl?.isNotEmpty ==
                                              true
                                          ? NetworkImage(profileController
                                              .profileModel.value!.avatarUrl!)
                                          : const AssetImage(
                                              'assets/img/avatar/Profile default.png'))
                                      as ImageProvider,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.textcolor),
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Овог"),
                        SizedBox(height: 5),
                        TextFormFieldWidget(
                          controller: lastNameController,
                        ),
                        SizedBox(height: 10),
                        Text("Нэр"),
                        SizedBox(height: 5),
                        TextFormFieldWidget(
                          controller: firstNameController,
                        ),
                        SizedBox(height: 10),
                        Text("И-Мэйл"),
                        SizedBox(height: 5),
                        TextFormFieldWidget(
                          controller: emailController,
                        ),
                        SizedBox(height: 10),
                        Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () =>
                                profileController.updateProfileData(
                                    lastNameController.text.trim(),
                                    firstNameController.text.trim(),
                                    emailController.text.trim()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.textcolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Text("Хадгалах",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => profileController.logOut(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.logout,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Text("Гарах",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
