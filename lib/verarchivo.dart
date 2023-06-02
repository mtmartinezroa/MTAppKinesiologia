import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'firebase_file.dart';

class VerArchivo extends StatefulWidget {
  final FirebaseFile file;
  const VerArchivo({
    Key? key,
    required this.file
  }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<VerArchivo> {
  late VideoPlayerController controller;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar( //Widget que contiene la barra superior de la app
        title: Text(widget.file.name),
        centerTitle: true,
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children:[
            AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),

            Container( //duration of video
              child: Text("Total Duration: " + controller.value.duration.toString()),
            ),

            Container(
              child: VideoProgressIndicator(
                controller,
                allowScrubbing: true,
                colors:VideoProgressColors(
                  backgroundColor: Colors.redAccent,
                  playedColor: Colors.green,
                  bufferedColor: Colors.purple,
                )
              )
            ),

            Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: (){
                      if(controller.value.isPlaying){
                        controller.pause();
                       }else{
                        controller.play();
                      }
                      setState(() {});
                   },
                  icon:Icon(controller.value.isPlaying?Icons.pause:Icons.play_arrow)
                  ),

                  IconButton(
                    onPressed: (){
                      controller.seekTo(Duration(seconds: 0));
                    setState(() {});
                   },
                  icon:Icon(Icons.stop)
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}