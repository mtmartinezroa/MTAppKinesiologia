import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';






class CrearcuentaPaciente extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CrearcuentaPaciente> {
  String password = '123456';
  bool bandera = false;
  late String? idPaciente;

  late FirebaseAuth userAuth = FirebaseAuth.instance;

  TextEditingController nPaciente = TextEditingController();
  TextEditingController ePaciente = TextEditingController();



  final formKey = GlobalKey<FormState>();


  Future crearCuenta(String email, String password) async{
    try {
      await userAuth.createUserWithEmailAndPassword(email: email, password: password);
      bandera=true;

    } catch (error) {

    }
  }

  void cancelar(){
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, '/crearcuentapaciente');
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
        title: const Text('Crear Cuenta del Paciente'),
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
                  controller: nPaciente,
                  decoration: InputDecoration(
                    label: Text('Nombre'),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                        Icons.email,
                        color: Colors.blue,
                    ),
                    hintText: 'Ingrese el nombre del paciente',
                  ),
                  validator: (String? value){
                    if(value==null || value.isEmpty) {
                      return 'Por favor ingrese el nombre';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller: ePaciente,
                  decoration: InputDecoration(
                    label: Text('Email'),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.blue,
                    ),
                    hintText: 'El correo del paciente',
                  ),
                  validator: (String? value){
                    if(value==null || value.isEmpty) {
                      return 'Por favor ingrese correo';
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
                        String nombrePaciente = nPaciente.text;
                        String correoPaciente = ePaciente.text;
                        await crearCuenta(correoPaciente, password);
                        if (bandera == true) {
                          Map<String, dynamic> DatosPaciente = {
                            'nombre': nombrePaciente,
                            'correo': correoPaciente,
                            'uid': userAuth.currentUser?.uid,
                            'posteado': FieldValue.serverTimestamp()
                          };
                          idPaciente = userAuth.currentUser?.uid;
                          CollectionReference baseDatos = FirebaseFirestore.instance.collection('lista_pacientes');
                          baseDatos.add(DatosPaciente);

                          showDialog(
                            context: context,
                            builder: (context) =>
                                AlertDialog(
                                  title: Text('Paciente creado!'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            'Haz creado una cuenta de un paciente'
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
                        }else{
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Error al crear cuenta!'),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        'Error al crear cuenta es posible que el email que ingresaste ya existe'
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                MaterialButton(
                                  onPressed: cancelar,
                                  child: Text("ACEPTAR"),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    child: Text('Registrar Paciente'),
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