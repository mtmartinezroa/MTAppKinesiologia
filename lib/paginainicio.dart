import 'package:flutter/material.dart';

class PaginaInicio extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PaginaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar( //Widget que contiene la barra superior de la app
        title: const Text('Pagina Inicio'),
        centerTitle: true,
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
      ),
      body: Center(child: SingleChildScrollView( //Widget que contiene la parte central de la app
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/ingresarcuentakine');
              },
              icon: const Icon(
                size: 30.0,
                Icons.assignment_outlined,
                color: Colors.red,
              ),
              label: const Text('Ingresar Cuenta Kinesiologo'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/crearcuentakine');
              },
              icon: const Icon(
                size: 30.0,
                Icons.assignment_outlined,
                color: Colors.red,
              ),
              label: const Text('Crear Cuenta Kinesiologo'),
            ),
            Image.asset('assets/imagenes/1.png'),
          ],
        ),
      ),
      ),
    );
  }
}