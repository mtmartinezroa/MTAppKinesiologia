import 'package:flutter/material.dart';
import 'package:mt_app_kinesiologia/paginaejercicio.dart';
import 'package:provider/provider.dart';
import 'package:mt_app_kinesiologia/clasesextra/programasData.dart';

class PaginaPrograma extends StatefulWidget {
  final String nombrePrograma;
  final String descripcion;
  const PaginaPrograma({
      super.key,
      required this.nombrePrograma,
      required this.descripcion
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PaginaPrograma> {
  List<String> items1 = <String>['Movilidad','Activacion','Elongacion',]; //CATEGORIA
  List<String> items2 = <String>['1','2','3','4','5','10','15','20',]; //REPETICIONES
  List<String> items3 = <String>['1','2','3','4','5','10','15','20',]; //TIEMPO
  List<String> items4 = <String>['1','2','3','4','5',]; //SETS
  String dropdownValueCategoria = 'Movilidad';
  String dropdownValueRepeticiones = '1';
  String dropdownValueTiempo = '1';
  String dropdownValueSets = '1';


  final nombreEjerIngresado = TextEditingController();
  //final nRepeticiones = TextEditingController();
  //final nTiempo = TextEditingController();
  //final nSets = TextEditingController();
  final descrip = TextEditingController();

  void crearEjercicio(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Agregar nuevo ejercicio'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'Ingrese el nombre del ejercicio'),
                  controller: nombreEjerIngresado,
                ),
                SizedBox(
                  height: 20,
                ),

                Text(
                    'Elegir la categoria'
                ),
                DropdownButtonFormField<String>(
                  value: dropdownValueCategoria,
                  onChanged: (String? value){
                    setState(() {
                      dropdownValueCategoria = value!;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      dropdownValueTiempo = value!;
                    });
                  },
                  items: items1.map<DropdownMenuItem<String>>(
                        (String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
                SizedBox(
                  height: 20,
                ),

                Text(
                    'Elegir el numero de repeticiones'
                ),
                DropdownButtonFormField<String>(
                  value: dropdownValueRepeticiones,
                  onChanged: (String? value){
                    setState(() {
                      dropdownValueRepeticiones = value!;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      dropdownValueRepeticiones = value!;
                    });
                  },
                  items: items2.map<DropdownMenuItem<String>>(
                        (String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
                SizedBox(
                  height: 20,
                ),

                Text(
                  'Elegir el tiempo en segundos'
                ),
                DropdownButtonFormField<String>(
                  value: dropdownValueTiempo,
                  onChanged: (String? value){
                    setState(() {
                      dropdownValueTiempo = value!;
                    });
                  },
                  onSaved: (value) {
                      setState(() {
                        dropdownValueTiempo = value!;
                      });
                  },
                  items: items3.map<DropdownMenuItem<String>>(
                        (String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
                SizedBox(
                  height: 20,
                ),

                Text(
                    'Elegir el numero de sets'
                ),
                DropdownButtonFormField<String>(
                  value: dropdownValueSets,
                  onChanged: (String? value){
                    setState(() {
                      dropdownValueSets = value!;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      dropdownValueSets = value!;
                    });
                  },
                  items: items4.map<DropdownMenuItem<String>>(
                        (String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
                SizedBox(
                  height: 20,
                ),

                TextField(
                  decoration: InputDecoration(hintText: 'Ingrese una descripcion del ejercicio'),
                  controller: descrip,
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
  void guardar(){ //guarda el nombre del ejercicio a crear y los datos de repeticiones , tiempo , sets
    String nombreNuevoEjercicio = nombreEjerIngresado.text;
    String numRepeticiones = dropdownValueRepeticiones;
    String numTiempo = dropdownValueTiempo;
    String numSets = dropdownValueSets;
    String descripcion = descrip.text;
    String categoria = dropdownValueCategoria;
    Provider.of<programasData>(context, listen: false).agregarEjercicio(
        widget.nombrePrograma,
        nombreNuevoEjercicio,
        numRepeticiones,
        numTiempo,
        numSets,
        descripcion,
        categoria
    );
    Navigator.pop(context);
    limpiar();
  }

  void cancelar(){ //cierra la ventana sin guardar nada
    Navigator.pop(context);
    limpiar();
  }

  void cerrar(){
    Navigator.pop(context);
  }

  void limpiar(){ //limpia el texto ingresado por el usuario luego de cerrar ventana
    nombreEjerIngresado.clear();
    descrip.clear();
    dropdownValueTiempo = '1';
    dropdownValueCategoria = 'Movilidad';
    dropdownValueSets = '1';
    dropdownValueRepeticiones = '1';
  }

  void IrPaginaEjercicio(
      String nombreEjercicio,
      String nombrePrograma,
      String numRepeticiones,
      String numTiempo,
      String numSets,
      String descripcion,
      String categoria){// funcion para acceder a la pagina del programa
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        PaginaEjercicio(
          nombreEjercicio: nombreEjercicio,
          nombrePrograma: nombrePrograma,
          nRepeticiones: numRepeticiones,
          nTiempo: numTiempo,
          nSets: numSets,
          descripcion: descripcion,
          categoria: categoria,
        ),));
  }

  void verDescripcion(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Descripcion del Programa'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.descripcion,
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

  @override
  Widget build(BuildContext context) {
    return Consumer<programasData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar( //Widget que contiene la barra superior de la app
          title: Text(widget.nombrePrograma),
          centerTitle: true,
          backgroundColor: Colors.blue[500],
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                verDescripcion();
              },
              icon: Icon(
                size: 30.0,
                Icons.info_outline_rounded,
                color: Colors.red,
               ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            crearEjercicio();
          },
          icon: Icon(
            size: 30.0,
            Icons.add,
            color: Colors.red,
          ),
          label: Text('Crear Ejercicio'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        body:

        ListView.builder(
            itemCount: value.numeroEjerciciosPrograma(widget.nombrePrograma),
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(
                  value.getProgramaActual(widget.nombrePrograma).ejercicios[index].nombre,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () =>
                      IrPaginaEjercicio(
                        value.getProgramaActual(widget.nombrePrograma).ejercicios[index].nombre,
                        widget.nombrePrograma,
                        value.getProgramaActual(widget.nombrePrograma).ejercicios[index].repeticiones,
                        value.getProgramaActual(widget.nombrePrograma).ejercicios[index].tiempo,
                        value.getProgramaActual(widget.nombrePrograma).ejercicios[index].sets,
                        value.getProgramaActual(widget.nombrePrograma).ejercicios[index].descripcion,
                        value.getProgramaActual(widget.nombrePrograma).ejercicios[index].categoria,
                      ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget> [
                    Text(
                      "${value.getProgramaActual(widget.nombrePrograma).ejercicios[index].repeticiones} reps"
                    ),
                    Text(
                       "${value.getProgramaActual(widget.nombrePrograma).ejercicios[index].tiempo} segs"
                    ),
                    Text(
                        "${value.getProgramaActual(widget.nombrePrograma).ejercicios[index].sets} sets"
                    ),
                  ],
                ),
                contentPadding: const EdgeInsets.all(20),
              ),
            ),
        ),
      ),
    );
  }
}