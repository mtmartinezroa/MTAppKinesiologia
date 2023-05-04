import 'package:flutter/material.dart';
import '/paginainicio.dart';
import '/menuprogramas.dart';
import '/editarprograma.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/paginainicio',
    routes: {
      '/paginainicio': (context) => PaginaInicio(),
      '/menuprogramas': (context) => MenuProgramas(),
      '/editarprograma': (context) => EditarPrograma(),

    }
));

