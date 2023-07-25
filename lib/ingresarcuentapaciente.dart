import 'package:flutter/material.dart';

class IngresarcuentaPaciente extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<IngresarcuentaPaciente> {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Email'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        hintText: 'Ingrese su email',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Contraseña'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.blue,
                        ),
                        hintText: 'Ingrese su contraseña',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Ingresar a cuenta'),
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