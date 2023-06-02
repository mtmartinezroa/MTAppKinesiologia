import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'verarchivo.dart';
import 'firebase_file.dart';

class VerPrograma extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<VerPrograma> {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
    Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async { //funcion que crea una lista de los archivos de la bd
    final ref = FirebaseStorage.instance.ref().child("archivos/");
    final result = await ref.listAll();
    final urls = await _getDownloadLinks(result.items);
    return urls
        .asMap()
        .map((index, url){
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);
          return MapEntry(index, file);
    })
    .values
    .toList();
  }

  Widget mostrarArchivos(BuildContext context, FirebaseFile file){ //Funcion que muestra archivos de la bd
    return Card(
      child: ListTile(
      leading: const Icon(
        size: 30.0,
        Icons.video_camera_front_outlined,
        color: Colors.red,
      ),
      trailing: const Icon(
        size: 30.0,
        Icons.play_arrow,
        color: Colors.black,
      ),
      title: Text(
        file.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
      ),
      contentPadding: const EdgeInsets.all(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  VerArchivo(file: file),
            )
          );
        }
      )
    );
  }

  late Future <List<FirebaseFile>> futureFiles;

  @override
  void initState(){
    super.initState();
    futureFiles = listAll('archivos/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar( //Widget que contiene la barra superior de la app
        title: const Text('Ver Programa 1'),
        centerTitle: true,
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
      ),
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context,snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if(snapshot.hasError) { // si existe algun error con la bd
                return Center(child: Text ('Error con los archivos'));
              }else{
                final files = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          final file = files[index];
                          return mostrarArchivos(context, file);
                        },
                      ),
                    ),
                  ],
                );
              }
              }
         }
     )
    );
  }

}
