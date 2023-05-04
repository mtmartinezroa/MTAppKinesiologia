import 'package:flutter/material.dart';

class EditarPrograma extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<EditarPrograma> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar( //Widget que contiene la barra superior de la app
        title: const Text('Editar Programa 1#'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
      ),
      body: Center( //Widget que contiene la parte central de la app
        child: Column(
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                size: 30.0,
                Icons.video_call_rounded,
                color: Colors.red,
              ),
              label: const Text('Añadir Video'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                size: 30.0,
                Icons.mic_rounded,
                color: Colors.red,
              ),
              label: const Text('Añadir Audio'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                size: 30.0,
                Icons.video_call_rounded,
                color: Colors.red,
              ),
              label: const Text('Añadir Texto'),
            ),
          ],
        ),
      ),
    );
  }
}