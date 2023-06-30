import 'package:flutter/material.dart';
import 'package:mt_app_kinesiologia/realizarejercicio.dart';
import 'package:provider/provider.dart';
import 'package:mt_app_kinesiologia/clasesextra/programasData.dart';
import 'agregarvideos.dart';
import 'listavideos.dart';


class PaginaEjercicio extends StatefulWidget {
  final String nombreEjercicio;
  final String nombrePrograma;
  final String nRepeticiones;
  final String nTiempo;
  final String nSets;
  final String descripcion;
  final String categoria;
  const PaginaEjercicio({
    super.key,
    required this.nombreEjercicio,
    required this.nombrePrograma,
    required this.nRepeticiones,
    required this.nTiempo,
    required this.nSets,
    required this.descripcion,
    required this.categoria
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PaginaEjercicio> {

  @override
  Widget build(BuildContext context) {
    return Consumer<programasData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar( //Widget que contiene la barra superior de la app
          title: Text(widget.nombreEjercicio),
          centerTitle: true,
          backgroundColor: Colors.blue[500],
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.edit_note),
              title: Text("Categoria :" + widget.categoria),
            ),
            ListTile(
              leading: Icon(Icons.repeat),
              title: Text(widget.nRepeticiones + " repeticiones"),
            ),
            ListTile(
              leading: Icon(Icons.timer_sharp),
              title: Text(widget.nTiempo + " segundos"),
            ),
            ListTile(
              leading: Icon(Icons.checklist),
              title: Text(widget.nSets + " sets"),
            ),
            ListTile(
              leading: Icon(Icons.description_outlined),
              title: Text(widget.descripcion),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                AgregarVideos(),));
              },
              icon: const Icon(
                size: 30.0,
                Icons.add,
                color: Colors.red,
              ),
              label: const Text('Agregar Videos'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    ListaVideos(),));
              },
              icon: const Icon(
                size: 30.0,
                Icons.add,
                color: Colors.red,
              ),
              label: const Text('Lista de Videos'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    RealizarEjercicio(
                      nTiempo: widget.nTiempo,
                      nRepeticiones: widget.nRepeticiones,
                      nSets: widget.nSets,
                    ),));
              },
              icon: const Icon(
                size: 30.0,
                Icons.add,
                color: Colors.red,
              ),
              label: const Text('Realizar Ejercicio'),
            ),
          ],
        )

      ),
    );
  }
}



