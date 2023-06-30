import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mt_app_kinesiologia/clasesextra/programasData.dart';
import 'package:mt_app_kinesiologia/paginaprograma.dart';

class ListaProgramas extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ListaProgramas> {
  final nombreNuevoPrograma = TextEditingController();
  final descripcionNuevoPrograma = TextEditingController();

  void crearPrograma(){ //funcion para crear programas nuevos
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Agregar nuevo programa'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Ingrese el nombre del programa'),
                controller: nombreNuevoPrograma,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Ingrese una descripcion del programa'),
                controller: descripcionNuevoPrograma,
              ),
            ],
          ),
        ),
        actions: [
            MaterialButton(
              onPressed: guardar,
              child: Text("GUARDAR"),
            ),
            MaterialButton(
              onPressed: cancelar,
              child: Text("CANCELAR"),
            ),
        ],
      ),
    );
  }

  void guardar(){ //guarda el nombre del programa ingresado por el usuario
    String nombrePrograma = nombreNuevoPrograma.text;
    String descripcion = descripcionNuevoPrograma.text;
    Provider.of<programasData>(context, listen: false).agregarPrograma(nombrePrograma,descripcion);
    Navigator.pop(context);
    limpiar();
  }

  void cancelar(){ //cierra la ventana de ingreso de nombre de ejercicio
    Navigator.pop(context);
    limpiar();
  }

  void limpiar(){ //limpia el texto ingresado por el usuario luego de cerrar ventana
    nombreNuevoPrograma.clear();
    descripcionNuevoPrograma.clear();
  }

  void IrPaginaPrograma(String nombrePrograma, String descripcion){// funcion para acceder a la pagina del programa
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        PaginaPrograma(
          nombrePrograma: nombrePrograma,
          descripcion: descripcion,
        ),));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<programasData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[200],
          appBar: AppBar( //Widget que contiene la barra superior de la app
            title: const Text('Lista Programas'),
            centerTitle: true,
            backgroundColor: Colors.blue[500],
            elevation: 0.0,
          ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            crearPrograma();
          },
          icon: Icon(
            size: 30.0,
            Icons.add,
            color: Colors.red,
          ),
          label: Text('Crear Programa'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: ListView.builder(
            itemCount: value.getListaProgramas().length,
            itemBuilder: (context, index) =>
              Card(
                child: ListTile(
                  title: Text(value.getListaProgramas()[index].nombre),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () =>
                        IrPaginaPrograma(
                          value.getListaProgramas()[index].nombre,
                          value.getListaProgramas()[index].descripcion,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
          ),
      ),
    );
  }
}