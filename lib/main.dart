import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mt_app_kinesiologia/clasesSuperUsuario/ingresarcuentakine.dart';
import 'clasesSuperUsuario/crearcuentakine.dart';
import 'firebase/firebase_options.dart';
import '/paginainicio.dart';
import 'clasesSuperUsuario/crearcuentapaciente.dart';
import 'clasesSuperUsuario/listapacientes.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyD_YXlvyODszzRAF7od45y2VyTJfBB2gOc",
        authDomain: "mtapp-a45cd.firebaseapp.com",
        projectId: "mtapp-a45cd",
        storageBucket: "mtapp-a45cd.appspot.com",
        messagingSenderId: "783444933701",
        appId: "1:783444933701:web:2807ca94518848e956f72c"
      ),
  );
  //await FirebaseAuth.instance.signInAnonymously();

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
            //'/ingresarcuentapaciente': (context) => IngresarcuentaPaciente(),
            //'/crearcuentakine': (context) => CrearcuentaKine(),
            '/ingresarcuentakine': (context) => IngresarcuentaKine(),
          }
        );
  }
}

