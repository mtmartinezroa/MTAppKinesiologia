import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mt_app_kinesiologia/clasesSuperUsuario/crearcuentapaciente.dart';
import 'package:mt_app_kinesiologia/listaprogramaspaciente.dart';

class ListaPacientes extends StatefulWidget {
  final String idk;
  const ListaPacientes({
    super.key,
    required this.idk,
  });


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ListaPacientes> {

  late var _reference;
  late Stream<QuerySnapshot> _stream;

  void IrPaginaPrograma(String id){// funcion para acceder a la pagina del programa
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        ListaprogramasPaciente(
          id: id,
        ),));
  }
  @override
  void initState(){
    super.initState();

    _reference = FirebaseFirestore.instance.collection('lista_pacientes').where("uid", isEqualTo: widget.idk);

    _stream = _reference.snapshots();




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar( //Widget que contiene la barra superior de la app
          title: Text('Lista Pacientes',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          backgroundColor: Colors.blue[500],
          elevation: 0.0,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                CrearcuentaPaciente(
                  idk: widget.idk,
                ),));
          },
          icon: Icon(
            size: 30.0,
            Icons.add,
            color: Colors.red,
          ),
          label: Text('Crear Paciente'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasError){
              return Text('Error');
            }

            if(snapshot.hasData){
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> listapacientes = querySnapshot.docs;
              List<Map> datos = listapacientes.map((e) => {
                'id': e.id,
                'nombre': e['nombre'],
                'correo': e['correo'],
              }).toList();

              return ListView.builder(
                itemCount: datos.length,
                itemBuilder:(BuildContext context, int index){
                  Map datoss = datos[index];
                  return Card(
                    child: ListTile(
                    title: Text('${datoss['nombre']}'),
                    subtitle: Text('${datoss['correo']}'),
                      contentPadding: const EdgeInsets.all(20),
                      trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () =>
                        IrPaginaPrograma(
                          datoss['id'],
                         ),
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






