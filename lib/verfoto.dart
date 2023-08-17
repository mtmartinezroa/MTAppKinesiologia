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
      body: Center(child: SingleChildScrollView( //Widget que contiene la parte central de la app
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            Image.network(widget.file.url),
          ],
        ),
      ),
      ),
    );
  }
}