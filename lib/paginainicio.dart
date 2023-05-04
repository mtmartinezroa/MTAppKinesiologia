import 'package:flutter/material.dart';

class PaginaInicio extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PaginaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar( //Widget que contiene la barra superior de la app
        title: const Text('Pagina Inicio'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
      ),
      body: Center( //Widget que contiene la parte central de la app
        child: Column(
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/menuprogramas');
              },
              icon: const Icon(
                size: 30.0,
                Icons.assignment_outlined,
                color: Colors.red,
              ),
              label: const Text('Menu Programas'),
            ),
            Image.network("https://picsum.photos/id/237/200/300"),
          ],
        ),
      ),
    );
  }
}