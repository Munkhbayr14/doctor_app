import 'package:app/core/utils/colors.dart';
import 'package:app/pages/screen/music/controller/music_controller.dart';

import 'package:app/pages/screen/music/view/music_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicWidget extends StatelessWidget {
  final music;
  MusicWidget({super.key, required this.music});
  final MusicController musicController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            await musicController.fetchDetaildata(music.id);
            Get.to(() => MusicDetail());
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                border: Border.all(color: AppColors.textcolor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.music_note,
                            color: Color(0xFF3287E0),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            music.title,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
