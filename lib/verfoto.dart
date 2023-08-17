import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'firebase/firebase_file.dart';

class VerFoto extends StatefulWidget {
  final FirebaseFile file;
  const VerFoto({
    Key? key,
    required this.file
  }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<VerFoto> {

  final ScrollController controller = ScrollController();
  final ScrollController controller2 = ScrollController();



  @override
  void initState() {
    super.initState();
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
      body: Center(child: Scrollbar( //Widget que contiene la parte central de la app
        controller: controller2,
        child: SingleChildScrollView(
          controller: controller2,
          scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
             controller: controller,
           child: Image.network(widget.file.url),
            )
        ),
      ),
      ),
    );
  }
}