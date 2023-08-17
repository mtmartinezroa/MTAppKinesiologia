import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'firebase/firebase_file.dart';

class VerVideo extends StatefulWidget {
  final FirebaseFile file;
  const VerVideo({
    Key? key,
    required this.file
  }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<VerVideo> {
  late VideoPlayerController controller;
  bool videoEjecutandose = false;
  bool finVideo = false;


  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer(){
    controller = VideoPlayerController.network(widget.file.url);
    controller.addListener(() {
      setState(() {});
    });

    controller.initialize().then((value){
      setState(() {});
    });
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar( //Widget que contiene la barra superior de la app
        title: Text(widget.file.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
         },
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
              )
            )
        )
    );
  }
}