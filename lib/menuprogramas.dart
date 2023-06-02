import 'package:flutter/material.dart';

class MenuProgramas extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MenuProgramas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar( //Widget que contiene la barra superior de la app
        title: const Text('Menu Programas'),
        centerTitle: true,
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
      ),
      body: Center( //Widget que contiene la parte central de la app
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                  Navigator.pushNamed(context, '/programa');
                  },
                  icon: const Icon(
                    size: 30.0,
                    Icons.add,
                    color: Colors.red,
                  ),
                  label: const Text('Editar Programa 1'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                  Navigator.pushNamed(context, '/verprograma');
                  },
                  icon: const Icon(
                    size: 30.0,
                    Icons.add,
                    color: Colors.red,
                  ),
                  label: const Text('Ver Programa 1'),
                ),

                ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/programa2');
                  },
                  icon: const Icon(
                    size: 30.0,
                    Icons.add,
                    color: Colors.red,
                  ),
                  label: const Text('Editar Programa 2'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/programa2');
                  },
                  icon: const Icon(
                    size: 30.0,
                    Icons.add,
                    color: Colors.red,
                  ),
                  label: const Text('Ver Programa 2'),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/programa3');
                  },
                  icon: const Icon(
                    size: 30.0,
                    Icons.add,
                    color: Colors.red,
                  ),
                  label: const Text('Editar Programa 3'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/programa3');
                  },
                  icon: const Icon(
                    size: 30.0,
                    Icons.add,
                    color: Colors.red,
                  ),
                  label: const Text('Ver Programa 3'),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}