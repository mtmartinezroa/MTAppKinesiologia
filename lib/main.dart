import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mt_app_kinesiologia/clasesSuperUsuario/ingresarcuentakine.dart';
import 'clasesSuperUsuario/crearcuentakine.dart';
import 'firebase/firebase_options.dart';
import '/paginainicio.dart';
import 'clasesSuperUsuario/crearcuentapaciente.dart';
import '/ingresarcuentapaciente.dart';
import 'clasesSuperUsuario/listapacientes.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.signInAnonymously();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          initialRoute: '/paginainicio',
          routes: {
            '/paginainicio': (context) => PaginaInicio(),
            '/ingresarcuentapaciente': (context) => IngresarcuentaPaciente(),
            '/crearcuentakine': (context) => CrearcuentaKine(),
            '/ingresarcuentakine': (context) => IngresarcuentaKine(),
          }
        );
  }
}

