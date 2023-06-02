import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_options.dart';
import '/paginainicio.dart';
import '/menuprogramas.dart';
import '/verarchivo.dart';
import '/programa.dart';
import '/programa2.dart';
import '/programa3.dart';
import '/verprograma.dart';


Future main() async{
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      );

      runApp(MaterialApp(
          initialRoute: '/paginainicio',
          routes: {
                '/paginainicio': (context) => PaginaInicio(),
                '/menuprogramas': (context) => MenuProgramas(),
                //'/verarchivo': (context) => VerArchivo(file:file),
                '/programa': (context) => Programa(),
                '/programa2': (context) => Programa2(),
                '/programa3': (context) => Programa3(),
                '/verprograma': (context) => VerPrograma(),

          }
      ));
}

