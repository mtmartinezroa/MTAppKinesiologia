import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'listapacientes.dart';

class IngresarcuentaKine extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<IngresarcuentaKine> {

  late String? idKinesiologo;
  late String idKine;

  bool bandera = false;

  TextEditingController eKine = TextEditingController();
  TextEditingController pKine = TextEditingController();

  final formKey = GlobalKey<FormState>();
  late FirebaseAuth userAuth = FirebaseAuth.instance;

  Future ingresarCuenta(String correoKinesiologo, String passwordKinesiologo)async{

    try {
      await userAuth.signInWithEmailAndPassword(email: correoKinesiologo, password: passwordKinesiologo);

      bandera=true;

    } catch (error) {

    }
  }

  Future irListaPacientes()async{

    idKinesiologo = userAuth.currentUser?.uid;

    idKine = idKinesiologo.toString();

    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        ListaPacientes(
          idk: idKine,
        ),));
  }



  void aceptar(){
    Navigator.pop(context);
  }

  void cancelar(){
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, '/ingresarcuentakine');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar( //Widget que contiene la barra superior de la app
          title: const Text('Ingresar Cuenta'),
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
                        hintText: 'Ingrese su correo',
                      ),
                      validator: (String? value){
                        if(value==null || value.isEmpty) {
                          return 'Por favor ingrese su correo';
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
                        label: Text('Contraseña'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        hintText: 'Ingrese su contraseña',
                      ),
                      validator: (String? value){
                        if(value==null || value.isEmpty) {
                          return 'Por favor ingrese su contraseña';
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
                            await ingresarCuenta(correoKine, passKine);
                            if (bandera == true){
                              irListaPacientes();

                              showDialog(
                                context: context,
                                builder: (context) =>
                                    AlertDialog(
                                      title: Text('Se ha ingresado a la cuenta!'),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                'Haz ingresado a tu cuenta de manera satisfactoria'
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
                                  title: Text('Error al ingresar a tu cuenta!'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            'Error al ingresar cuenta, revisa tu correo y contraseña'
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
                        child: Text('Ingresar a cuenta kinesiologo'),
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