import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CrearcuentaKine extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CrearcuentaKine> {

  bool bandera = false;


  late FirebaseAuth userAuth = FirebaseAuth.instance;

  TextEditingController eKine = TextEditingController();
  TextEditingController pKine = TextEditingController();



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
    Navigator.pushNamed(context, '/crearcuentakine');
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
          title: const Text('Crear Cuenta del Kinesiologo'),
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
                      controller: eKine,
                      decoration: InputDecoration(
                        label: Text('Email'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        hintText: 'Ingrese su email',
                      ),
                      validator: (String? value){
                        if(value==null || value.isEmpty) {
                          return 'Por favor ingrese su email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      controller: pKine,
                      decoration: InputDecoration(
                        label: Text('Contraseña, min 6 caracteres'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.blue,
                        ),
                        hintText: 'Ingrese su contraseñae',
                      ),
                      validator: (String? value){
                        if(value==null || value.isEmpty) {
                          return 'Por favor ingrese su contraseña, min 6 caracteres';
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
                            String correoKine = eKine.text;
                            String passKine = pKine.text;
                            await crearCuenta(correoKine, passKine);
                            if (bandera == true) {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    AlertDialog(
                                      title: Text('Cuenta Creada!'),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                'Haz creado una cuenta de un kinesiologo'
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
                                            'Error al crear cuenta es posible que el email que ingresaste ya existe o tu contraseña es menor a 6 caracteres'
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
                        child: Text('Registrar Cuenta Kinesiologo'),
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