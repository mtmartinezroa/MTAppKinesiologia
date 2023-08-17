import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mt_app_kinesiologia/listaejercicios.dart';
import 'clasesSuperUsuario/crearprograma.dart';


class ListaprogramasPaciente extends StatefulWidget {
  final String id;
  const ListaprogramasPaciente({
    super.key,
    required this.id,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ListaprogramasPaciente> {

  late DocumentReference _referencePaciente;
  late CollectionReference _referencePrograma;
  late Stream<QuerySnapshot> _streamPrograma;

  @override
  void initState(){
    super.initState();
    _referencePaciente = FirebaseFirestore.instance.collection('lista_pacientes').doc(widget.id);
    _referencePrograma = _referencePaciente.collection('programas');

    _streamPrograma = _referencePrograma.orderBy('posteado',descending: false).snapshots();

  }

  void IrPaginaCrearPrograma(String id){// funcion para acceder a la pagina del programa
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        CrearPrograma(
          id: id,
        ),));
  }

  void IrListaEjercicios(String idPaciente, String idPrograma){// funcion para acceder a la pagina del programa
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        ListaEjercicios(
          idPaciente: idPaciente,
          idPrograma: idPrograma
        ),));
  }

  void verDescripcion(String Descripcion){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Descripcion del Programa'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Descripcion,
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar( //Widget que contiene la barra superior de la app
          title: Text('Lista de Programas',
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
            IrPaginaCrearPrograma(widget.id);
          },
          icon: Icon(
            size: 30.0,
            Icons.add,
            color: Colors.red,
          ),
          label: Text('Crear Programa'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: StreamBuilder<QuerySnapshot>(
            stream: _streamPrograma,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasError){
                return Text('Error');
              }

              if(snapshot.hasData){
                QuerySnapshot querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> listaprogramasPaciente = querySnapshot.docs;
                List<Map> datos = listaprogramasPaciente.map((e) => {
                  'id': e.id,
                  'descripcion': e['descripcion'],
                  'nombre': e['nombre'],
                }).toList();

                return ListView.builder(
                    itemCount: datos.length,
                    itemBuilder:(BuildContext context, int index){
                      Map datoss = datos[index];
                      return Card(
                          child: ListTile(
                              leading: IconButton(
                                icon: Icon(Icons.info_outlined),
                                onPressed: () {
                                verDescripcion(datoss['descripcion']);
                              },),
                          title: Text('${datoss['nombre']}'),
                              contentPadding: const EdgeInsets.all(20),
                              trailing: IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  IrListaEjercicios(widget.id,datoss['id']);
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



