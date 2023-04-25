import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold( //Widget "Padre" que contiene a los demas
      appBar: AppBar( //Widget que contiene la barra superior de la app
        title: const Text('Menu Principal'),
        centerTitle: true
      ),
      body: const Center( //Widget que contiene el cuerpo de la app
        child: Text('Hola este es el menu principal'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Text('+a'),
      ),
    ),
  ));
}
