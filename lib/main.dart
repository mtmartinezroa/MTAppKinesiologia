import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import '/paginainicio.dart';
import '/menuprogramas.dart';
import '/verarchivo.dart';
import '/programa.dart';
import '/programa2.dart';
import '/programa3.dart';
import '/verprograma.dart';
import '/listaprogramas.dart';
import '/paginaprograma.dart';
import 'package:mt_app_kinesiologia/clasesextra/programasData.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => programasData(),
        child: MaterialApp(
          initialRoute: '/paginainicio',
          routes: {
            '/paginainicio': (context) => PaginaInicio(),
            '/menuprogramas': (context) => MenuProgramas(),
            '/listaprogramas': (context) => ListaProgramas(),
            //'/paginaprograma': (context) => PaginaPrograma(),
            '/programa': (context) => Programa(),
            '/programa2': (context) => Programa2(),
            '/programa3': (context) => Programa3(),
            '/verprograma': (context) => VerPrograma(),
          }
        ),
    );
  }
}

