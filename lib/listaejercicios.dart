import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mt_app_kinesiologia/verejercicio.dart';

import 'clasesSuperUsuario/crearejercicio.dart';


class ListaEjercicios extends StatefulWidget {
  final String idPaciente;
  final String idPrograma;

  const ListaEjercicios({
    super.key,
    required this.idPaciente,
    required this.idPrograma
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ListaEjercicios> {
  late String idBorrarEjercicio;
  late DocumentReference borrarEjer;

  late DocumentReference _referencePaciente;
  late DocumentReference _referencePrograma;
  late CollectionReference _referenceEjercicio;
  late Stream<QuerySnapshot> _streamEjercicio;




  @override
  void initState(){
    super.initState();
    _referencePaciente = FirebaseFirestore.instance.collection('lista_pacientes').doc(widget.idPaciente);
    _referencePrograma = _referencePaciente.collection('programas').doc(widget.idPrograma);
    _referenceEjercicio = _referencePrograma.collection('ejercicios');

    _streamEjercicio = _referenceEjercicio.orderBy('posteado',descending: false).snapshots();

  }

  void IrPaginaCrearEjercicio(String idPaciente, String idPrograma){// funcion para acceder a la pagina del programa
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        CrearEjercicio(
            idPaciente: idPaciente,
            idPrograma: idPrograma
        ),));
  }

  void IrVerEjercicio(
      String idPaciente,
      String idPrograma,
      String idEjercicio,
      String nombre,
      String categoria,
      String subcategoria,
      String repeticiones,
      String sets,
      String tiempo,
      String descripcion
      ){// funcion para acceder a la pagina del ejercicio
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        VerEjercicio(
            idPaciente: idPaciente,
            idPrograma: idPrograma,
            idEjercicio: idEjercicio,
            nombreEjercicio: nombre,
            categoria: categoria,
            subcategoria: subcategoria,
            repeticiones: repeticiones,
            sets: sets,
            tiempo: tiempo,
            descripcion: descripcion
        ),));
  }

  void borrarPrograma()async{
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Borrar Programa'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      '¿Esta seguro que desea borrar el programa y todos sus ejercicios?'
                  ),
                ],
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: aceptar,
                child: Text("ACEPTAR"),
              ),

              MaterialButton(
                onPressed: cancelar,
                child: Text("CANCELAR"),
              ),
            ],
          ),
    );
  }

 void borrarEjercicio(String idEjercicioABorrar)async{
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Borrar Ejercicio'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      '¿Esta seguro que desea borrar el ejercicio?'
                  ),
                ],
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () => aceptarE(idEjercicioABorrar),
                child: Text("ACEPTAR"),
              ),

              MaterialButton(
                onPressed: cancelar,
                child: Text("CANCELAR"),
              ),
            ],
          ),
    );
  }

  void aceptarE(String idEjercicioABorrar1)async{
    borrarEjer = _referencePrograma.collection('ejercicios').doc(idEjercicioABorrar1);
    borrarEjer.delete();
    Navigator.pop(context);
  }





  void cancelar(){
    Navigator.pop(context);
  }

  void aceptar()async{
    await _referencePrograma.delete();
    Navigator.pop(context);
    Navigator.pop(context);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar( //Widget que contiene la barra superior de la app
          title: Text('Lista de ejercicios'),
          centerTitle: true,
          backgroundColor: Colors.blue[500],
          elevation: 0.0,
          actions: [
            IconButton(onPressed: ()async{
              borrarPrograma();
            },
            icon: Icon(Icons.delete_forever)),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            IrPaginaCrearEjercicio(widget.idPaciente,widget.idPrograma);
          },
          icon: Icon(
            size: 30.0,
            Icons.add,
            color: Colors.red,
          ),
          label: Text('Crear Ejercicio'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: StreamBuilder<QuerySnapshot>(
            stream: _streamEjercicio,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasError){
                return Text('Error');
              }

              if(snapshot.hasData){
                QuerySnapshot querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> listaejerciciosPaciente = querySnapshot.docs;
                List<Map> datos = listaejerciciosPaciente.map((e) => {
                  'id': e.id,
                  'nombre': e['nombre'],
                  'categoria': e['categoria'],
                  'subcategoria': e['subcategoria'],
                  'repeticiones': e['repeticiones'],
                  'sets': e['sets'],
                  'tiempo': e['tiempo'],
                  'descripcion': e['descripcion'],
                }).toList();

                return ListView.builder(
                    itemCount: datos.length,
                    itemBuilder:(BuildContext context, int index){
                      Map datoss = datos[index];
                      return Card(
                          child: ListTile(
                              leading: IconButton(
                                icon: Icon(Icons.delete_forever),
                                onPressed: () {
                                  idBorrarEjercicio = datoss['id'].toString();
                                  borrarEjercicio(idBorrarEjercicio);
                                },),


                              title: Text('${datoss['nombre']}'),
                              contentPadding: const EdgeInsets.all(20),
                              trailing: IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  IrVerEjercicio(
                                      widget.idPaciente,
                                      widget.idPrograma,
                                      datoss['id'],
                                      datoss['nombre'],
                                      datoss['categoria'],
                                      datoss['subcategoria'],
                                      datoss['repeticiones'],
                                      datoss['sets'],
                                      datoss['tiempo'],
                                      datoss['descripcion'],
                                  );
                                },
                              )
                          )
                      );

                    }
                );

              }
              return Center(child: CircularProgressIndicator());

            }

        )

    );

  }
}



