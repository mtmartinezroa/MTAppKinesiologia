import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrearPrograma extends StatefulWidget {
  final String id;
  const CrearPrograma({
    super.key,
    required this.id,
  });
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CrearPrograma> {

  TextEditingController descripcionPrograma = TextEditingController();
  TextEditingController nPrograma = TextEditingController();

  late DocumentReference _referencePaciente;
  late CollectionReference _referencePrograma;
  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    _referencePaciente = FirebaseFirestore.instance.collection('lista_pacientes').doc(widget.id);
    _referencePrograma = _referencePaciente.collection('programas');
  }



  void aceptar(){
    Navigator.pop(context);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar( //Widget que contiene la barra superior de la app
          title: const Text('Crear Programa'),
          centerTitle: true,
          backgroundColor: Colors.blue[500],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 40.0),

              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nPrograma,
                      decoration: InputDecoration(
                        label: Text('Nombre'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.drive_file_rename_outline_rounded,
                          color: Colors.blue,
                        ),
                        hintText: 'Ingrese el nombre del programa',
                      ),
                      validator: (String? value){
                        if(value==null || value.isEmpty) {
                          return 'Por favor ingrese el nombre del programa';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      controller: descripcionPrograma,
                      decoration: InputDecoration(
                        label: Text('Descripcion'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.blue,
                        ),
                        hintText: 'La descripcion del programa',
                      ),
                      validator: (String? value){
                        if(value==null || value.isEmpty) {
                          return 'Por favor ingrese la descripcion del programa';
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            String nombrePrograma = nPrograma.text;
                            String descripPrograma = descripcionPrograma.text;
                            Map<String, dynamic> DatosPrograma = {
                              'descripcion': descripPrograma,
                              'nombre': nombrePrograma,
                              'posteado' : FieldValue.serverTimestamp()
                            };
                            _referencePrograma.add(DatosPrograma);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Programa Creado!'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          'Haz creado un programa'
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  MaterialButton(
                                    onPressed: aceptar,
                                    child: Text("ACEPTAR"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Text('Crear Programa'),
                      ),
                    ),
                  ],
                ),
              ),
            )
        )

    );
  }
}