import 'package:app/core/utils/colors.dart';
import 'package:app/pages/screen/music/controller/music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MusicDetail extends StatelessWidget {
  MusicDetail({super.key});
  final MusicController musicController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Дэлгэрэнгүй",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(),
        child: RefreshIndicator(
            onRefresh: () async {},
            child: ListView(children: [
              Column(
                children: [
                  Obx(() {
                    final controller =
                        musicController.youtubePlayerController.value;
                    if (controller == null) {
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.videocam_off, size: 48),
                              const SizedBox(height: 8),
                              Text(
                                "Видео байхгүй байна",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        YoutubePlayer(
                          controller: controller,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.blueAccent,
                          onReady: () {},
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      )),
                      Expanded(
                        child: Text(
                          musicController.musicDetailModel.value!.title,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.picture_as_pdf),
                    label: Text("PDF харах"),
                    onPressed: () {
                      final file = musicController.musicDetailModel.value?.file;
                      if (file != null && file.isNotEmpty) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) => DraggableScrollableSheet(
                            expand: false,
                            initialChildSize: 0.85,
                            minChildSize: 0.5,
                            maxChildSize: 0.95,
                            builder: (context, scrollController) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SfPdfViewer.network(
                                    file,
                                    canShowScrollHead: true,
                                    canShowScrollStatus: true,
                                    enableDoubleTapZooming: true,
                                    scrollDirection:
                                        PdfScrollDirection.vertical,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        Get.snackbar("🧐!", "📄 PDF файл байхгүй байна",
                            backgroundColor: Colors.amber);
                      }
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "🎵 Дууны бүрэлдэхүүн",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Audio List Section
                      Obx(() {
                        if (musicController.isLoadingAudio.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (musicController.musicDetailModel.value?.audio ==
                                null ||
                            musicController
                                .musicDetailModel.value!.audio.isEmpty) {
                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "🔇 Аудио файл байхгүй байна",
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        }

                        return Column(
                          children: musicController
                              .musicDetailModel.value!.audio
                              .map<Widget>((audio) {
                            final isCurrentAudio =
                                musicController.currentAudioUrl.value ==
                                    audio.url;
                            final isPlaying = isCurrentAudio &&
                                musicController.isPlaying.value;

                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  isPlaying
                                      ? Icons.equalizer
                                      : Icons.music_note,
                                  color: isPlaying
                                      ? Colors.blue
                                      : Colors.grey[700],
                                ),
                                title: Text(
                                  audio.voice,
                                  style: TextStyle(
                                    fontWeight: isCurrentAudio
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                subtitle: isCurrentAudio
                                    ? StreamBuilder<Duration>(
                                        stream: musicController
                                            .player.positionStream,
                                        builder: (context, snapshot) {
                                          final position =
                                              snapshot.data ?? Duration.zero;
                                          final duration =
                                              musicController.player.duration ??
                                                  Duration.zero;
                                          return LinearProgressIndicator(
                                            value: duration.inSeconds > 0
                                                ? position.inSeconds /
                                                    duration.inSeconds
                                                : 0,
                                            backgroundColor: Colors.grey[300],
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.blue),
                                          );
                                        },
                                      )
                                    : null,
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isCurrentAudio &&
                                        musicController.isBuffering.value)
                                      const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      )
                                    else
                                      IconButton(
                                        icon: Icon(
                                          isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () async {
                                          if (isPlaying) {
                                            await musicController.player
                                                .pause();
                                          } else {
                                            await musicController
                                                .playAudio(audio.url);
                                          }
                                        },
                                      ),
                                    IconButton(
                                      icon: const Icon(Icons.stop),
                                      onPressed: isCurrentAudio
                                          ? () async {
                                              await musicController.player
                                                  .stop();
                                              musicController.isPlaying.value =
                                                  false;
                                            }
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ])),
      ),
    );
  }
}
