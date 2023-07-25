import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'vervideo.dart';
import 'firebase/firebase_file.dart';

class ListaVideos extends StatefulWidget {
  final String idEjercicio;

  const ListaVideos({
    super.key,
    required this.idEjercicio,

  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ListaVideos> {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  Future<List<FirebaseFile>> listAll(String path) async { //funcion que crea una lista de los archivos de la bd
    final ref = FirebaseStorage.instance.ref().child("archivos/"+widget.idEjercicio+"/");
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
                  MaterialPageRoute(builder: (context) =>  VerVideo(file: file),
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
    futureFiles = listAll('archivos/'+widget.idEjercicio+'/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar( //Widget que contiene la barra superior de la app
          title: Text('Lista Videos'),
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
        ),
    );
  }

}




