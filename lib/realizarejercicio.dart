import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mt_app_kinesiologia/clasesextra/programasData.dart';



class RealizarEjercicio extends StatefulWidget {
  final String nTiempo;
  final String nRepeticiones;
  final String nSets;
  const RealizarEjercicio({
    super.key,
    required this.nTiempo,
    required this.nRepeticiones,
    required this.nSets,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<RealizarEjercicio> {
int verificador = 0;
int verificadorSets = 0;
int maxSegundos = 1;
int segundos = 1;
int sets = 1;
Timer? timer;


void avisoTermino(){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Set Completado'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Felicidades haz completado las repeticiones de este set!'
            ),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: cerrar,
          child: Text("CERRAR"),
        ),
      ],
    ),
  );
}
void avisoTerminoSets(){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Ejercicio Completado'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Felicidades haz completado todos los sets!'
            ),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: cerrar,
          child: Text("CERRAR"),
        ),
      ],
    ),
  );
}

void cerrar(){
  Navigator.pop(context);
}


Widget contadorCircular() => SizedBox(
  width: 100,
  height: 100,
  child: Stack(
    fit: StackFit.expand,
    children: [
      CircularProgressIndicator(
        value: segundos / maxSegundos ,
        strokeWidth: 6,
      ),
      Center(child:contadorTiempo())
    ],
  ),
);



Widget contadorTiempo(){
  return Text(
    '$segundos',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 80,
    ),
  );
}

void comenzarContador(){
  if (segundos == 0) {
    reiniciarTiempo();
  }
  timer = Timer.periodic(Duration(seconds: 1), (_){
    if(segundos>0) {
      setState(() => segundos--);
    } else {
      detenerTiempo();
      setState(() {
        verificador++;
      });

      if (verificador == int.parse(widget.nRepeticiones)&&verificadorSets == int.parse(widget.nSets)) {
        avisoTerminoSets();
      } else {
        if(verificador == int.parse(widget.nRepeticiones)) {

          avisoTermino();
          setState(() {
            verificador = 0;
            reiniciarTiempo();
            verificadorSets++;
          });
        }
      }
    }
  });
}

void reiniciarTiempo() => setState(() => segundos = maxSegundos);

void detenerTiempo(){

  timer?.cancel();
}

void reiniciarEjercicio(){
  setState(() {
    verificador=0;
    verificadorSets=0;
    reiniciarTiempo();
  });
}


@override
void initState() {
  maxSegundos = int.parse(widget.nTiempo);
  segundos = maxSegundos;
  sets = int.parse(widget.nSets);
}

  @override
  Widget build(BuildContext context) {
    return Consumer<programasData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar( //Widget que contiene la barra superior de la app
            title: Text('Realizar Ejercicio'),
            centerTitle: true,
            backgroundColor: Colors.blue[500],
            elevation: 0.0,
          ),

          body: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text("Repeticion numero : "+verificador.toString()+ " de " + widget.nRepeticiones),
              ),
              ListTile(
                leading: Icon(Icons.settings_accessibility_sharp),
                title: Text("Set numero : "+verificadorSets.toString()+ " de " + widget.nSets),
              ),
              contadorCircular(),
              ElevatedButton.icon(
                onPressed: () {
                  comenzarContador();
                },
                icon: const Icon(
                  size: 30.0,
                  Icons.add,
                  color: Colors.red,
                ),
                label: const Text('Iniciar Contador'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  reiniciarEjercicio();
                },
                icon: const Icon(
                  size: 30.0,
                  Icons.add,
                  color: Colors.red,
                ),
                label: const Text('Reiniciar Ejercicio'),
              ),
              ]
          ),




      ),


    );
  }
}



