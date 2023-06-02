import 'package:flutter/material.dart';

class Programa2 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Programa2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar( //Widget que contiene la barra superior de la app
        title: const Text('Programa 2'),
        centerTitle: true,
        backgroundColor: Colors.blue[500],
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