import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold( //Widget "Padre" que contiene a los demas
      appBar: AppBar( //Widget que contiene la barra superior de la app
        title: const Text('Menu Principal'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[400],
      ),
      body: Center( //Widget que contiene el cuerpo de la app
        child: Text(
          'Hola este es el menu principal',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.grey[600],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Text('+a'),
      ),
    ),
  ));
}
