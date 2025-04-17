import 'dart:developer';

import 'package:app/core/api/dio_client.dart';
import 'package:app/pages/screen/music/model/music_detail_model.dart' as detail;
import 'package:app/pages/screen/music/model/music_model.dart' as list;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MusicController extends GetxController {
  var isLoading = false.obs;
  var musicModel = <list.Result>[].obs;
  var musicDetailModel = Rxn<detail.Result>();
  var youtubePlayerController = Rxn<YoutubePlayerController>();
  var showPdf = false.obs;
  final player = AudioPlayer();
  final currentAudioUrl = ''.obs;
  final isPlaying = false.obs;
  final isBuffering = false.obs;
  final isLoadingAudio = false.obs;

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

  final Dio dio = DioClient().getInstance();

  @override
  void onInit() {
    fetchMusicdata();
    super.onInit();
  }

  Future<void> fetchMusicdata() async {
    try {
      var response = await dio.get("music/all");
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var fetchModel = list.MusicModel.fromJson(response.data);
        log("${fetchModel}");
        musicModel.value = fetchModel.result;
      }
    } catch (e) {
      print("Error fetching music list: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDetaildata(int id) async {
    log("Fetching details for ID: $id");
    try {
      isLoading.value = true;
      var response = await dio.get("music/$id");
      log("===> ${response}");
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var fetchDetailModel = detail.MusicDetailModel.fromJson(response.data);
        musicDetailModel.value = fetchDetailModel.result;

        final videoId = YoutubePlayer.convertUrlToId(
            fetchDetailModel.result.musicUrl ?? '');
        if (videoId != null) {
          youtubePlayerController.value = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
              enableCaption: false,
            ),
          );
        } else {
          log("Invalid YouTube URL: ${fetchDetailModel.result.musicUrl}");
          youtubePlayerController.value = null;
        }
      }
    } catch (e) {
      log("Error fetching music detail: $e");
      youtubePlayerController.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> playAudio(String url) async {
    try {
      currentAudioUrl.value = url;
      isBuffering.value = true;

      await player.setUrl(url);
      await player.play();

      isPlaying.value = true;
      isBuffering.value = false;
    } catch (e) {
      isBuffering.value = false;
      Get.snackbar(
        "Алдаа",
        "Дуу тоглуулахад асуудал гарлаа: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
