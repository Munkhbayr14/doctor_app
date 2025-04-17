import 'package:app/core/utils/colors.dart';
import 'package:app/pages/screen/music/controller/music_controller.dart';
import 'package:app/pages/screen/music/view/music_widget.dart';
import 'package:app/pages/screen/profile/controller/profile_controller.dart';
import 'package:app/pages/screen/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicScreen extends StatelessWidget {
  MusicScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());
  final MusicController musicController = Get.put(MusicController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Obx(
                () => Row(
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
                              border: Border.all(color: AppColors.textcolor),
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                image: profileController.profileModel.value
                                            ?.avatarUrl?.isNotEmpty ==
                                        true
                                    ? NetworkImage(profileController
                                        .profileModel.value!.avatarUrl!)
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
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.textcolor),
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFF0EDFF)),
                          child: Text(
                            profileController.profileModel.value?.firstName ??
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
                      onPressed: () => print("Notification clicked!"),
                      icon: Icon(Icons.notifications, color: Colors.black87),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextField(
                onChanged: (value) {
                  print("Searching: $value");
                },
                decoration: InputDecoration(
                  hintText: 'Хайх...',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppColors.textcolor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: AppColors.textcolor, width: 1),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF0EDFF),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                return RefreshIndicator(
                  onRefresh: () async {
                    await profileController.fetchProfileData();
                    await musicController.fetchMusicdata();
                  },
                  child: musicController.musicModel.isEmpty
                      ? SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Center(
                              child: Text("🎵 Дуу байхгүй байна өө хө 🎵"),
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemCount: musicController.musicModel.length,
                          itemBuilder: (context, index) {
                            final music = musicController.musicModel[index];
                            return MusicWidget(music: music);
                          },
                        ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
