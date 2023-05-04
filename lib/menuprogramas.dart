import 'package:flutter/material.dart';

class MenuProgramas extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MenuProgramas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar( //Widget que contiene la barra superior de la app
        title: const Text('Menu Programas'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
      ),
      body: Center( //Widget que contiene la parte central de la app
        child: Column(
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/editarprograma');
              },
              icon: const Icon(
                size: 30.0,
                Icons.add,
                color: Colors.red,
              ),
              label: const Text('Añadir Programa'),
            ),
          ],
        ),
      ),
    );
  }
}