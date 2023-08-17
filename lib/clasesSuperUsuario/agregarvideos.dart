import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AgregarVideos extends StatefulWidget {
  final String idEjercicio;

  const AgregarVideos({
    super.key,
    required this.idEjercicio,

  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<AgregarVideos> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future elegirVideo() async { // funcion que elige el archivo que queremos subir a la bd
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future subirVideo() async {  // funcion que sube el archivo a la bd
    if(pickedFile == null) return;
    final path = 'archivos/videos/'+widget.idEjercicio+'/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {});
    final linkVideo = await snapshot.ref.getDownloadURL();

    setState(() {
      uploadTask = null;
    });

  }

  Widget barraProgreso() => StreamBuilder<TaskSnapshot>( // este widget sirve para mostrar la borra de progreso al subir un archivo
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot){
        if (snapshot.hasData){
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                      child: Text(
                        '${(100 * progress).roundToDouble()}%',
                        style: const TextStyle(color: Colors.white),
                      )
                  ),
                ],
              )
          );

        } else {
          return const SizedBox(height: 50);
        }
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar( //Widget que contiene la barra superior de la app
          title: Text('Agregar Videos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          backgroundColor: Colors.blue[500],
          elevation: 0.0,
        ),
      body: Center( //Widget que contiene la parte central de la app
        child: Column(
          children: [
            ElevatedButton.icon( //boton para elegir video
              onPressed: () {
                elegirVideo();
              },
              icon: const Icon(
                size: 30.0,
                Icons.video_call_rounded,
                color: Colors.red,
              ),
              label: const Text('Elegir Video'),
            ),
            SizedBox(height: 5),

            if (pickedFile == null)
              Text(
                  'No se ha seleccionado un archivo aun'
              ),
            if (pickedFile != null)
              Text(
                  pickedFile!.name
              ),
            SizedBox(height: 8),
            ElevatedButton.icon( //boton para subir video
              onPressed: () {
                subirVideo();
              },
              icon: const Icon(
                size: 30.0,
                Icons.cloud_upload_rounded,
                color: Colors.red,
              ),
              label: const Text('Subir Video a BD'),
            ),
            barraProgreso(),
          ],
        ),
      ),
    );
  }
}



