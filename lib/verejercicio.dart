import 'package:flutter/material.dart';
import 'package:mt_app_kinesiologia/listafotos.dart';
import 'package:mt_app_kinesiologia/realizarejercicio.dart';
import 'clasesSuperUsuario/agregarfotos.dart';
import 'clasesSuperUsuario/agregarvideos.dart';
import 'listavideos.dart';



class VerEjercicio extends StatefulWidget {
  final String idPaciente;
  final String idPrograma;
  final String idEjercicio;
  final String nombreEjercicio;
  final String categoria;
  final String subcategoria;
  final String repeticiones;
  final String sets;
  final String tiempo;
  final String descripcion;

  const VerEjercicio({
    super.key,
    required this.idPaciente,
    required this.idPrograma,
    required this.idEjercicio,
    required this.nombreEjercicio,
    required this.categoria,
    required this.subcategoria,
    required this.repeticiones,
    required this.sets,
    required this.tiempo,
    required this.descripcion

  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<VerEjercicio> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar( //Widget que contiene la barra superior de la app
          title: Text(widget.nombreEjercicio,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          backgroundColor: Colors.blue[500],
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.edit_note),
              title: Text("Categoria : " + widget.categoria),
            ),
            ListTile(
              leading: Icon(Icons.subject_rounded),
              title: Text("Subcategoria : " + widget.subcategoria),
            ),
            ListTile(
              leading: Icon(Icons.repeat),
              title: Text(widget.repeticiones + " repeticiones"),
            ),
            ListTile(
              leading: Icon(Icons.timer_sharp),
              title: Text(widget.tiempo + " segundos"),
            ),
            ListTile(
              leading: Icon(Icons.checklist),
              title: Text(widget.sets + " series"),
            ),
            ListTile(
              leading: Icon(Icons.description_outlined),
              title: Text(widget.descripcion),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    AgregarVideos(idEjercicio: widget.idEjercicio,),));
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
                    AgregarFotos(idEjercicio: widget.idEjercicio,),));
              },
              icon: const Icon(
                size: 30.0,
                Icons.add,
                color: Colors.red,
              ),
              label: const Text('Agregar Fotos'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    ListaVideos(idEjercicio: widget.idEjercicio,),));
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
                    ListaFotos(idEjercicio: widget.idEjercicio,),));
              },
              icon: const Icon(
                size: 30.0,
                Icons.add,
                color: Colors.red,
              ),
              label: const Text('Lista de Fotos'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    RealizarEjercicio(
                      nombreEjercicio: widget.nombreEjercicio,
                      nTiempo: widget.tiempo,
                      nRepeticiones: widget.repeticiones,
                      nSets: widget.sets,
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
    );
  }
}



