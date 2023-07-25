import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrearEjercicio extends StatefulWidget {
  final String idPaciente;
  final String idPrograma;
  const CrearEjercicio({
    super.key,
    required this.idPaciente,
    required this.idPrograma
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CrearEjercicio> {
  late DocumentReference _referencePaciente;
  late DocumentReference _referencePrograma;
  late CollectionReference _referenceEjercicio;
  final formKey = GlobalKey<FormState>();

  List<String> items1 = <String>['Otros','Movilidad','Activacion','Elongacion',]; //CATEGORIA
  List<String> items2 = <String>['1','2','3','4','5','10','15','20',]; //REPETICIONES
  List<String> items3 = <String>['1','2','3','4','5','10','15','20','60','90','120','150','180','240','300']; //TIEMPO
  List<String> items4 = <String>['1','2','3','4','5','6','7','8','9','10']; //SETS
  List<String> items5 = <String>[
    'Otros',
    'Extremidad Superior',
    'Extremidad Inferior',
    'C.Cervical',
    'C.Lumbar',
    'C.Dorsal',
    'Hombro',
    'Codo',
    'Muñeca/Mano',
    'Cadera',
    'Rodilla',
    'Tobillo/Pie',
  ];

  String dropdownValueCategoria = 'Otros';
  String dropdownValueRepeticiones = '1';
  String dropdownValueTiempo = '1';
  String dropdownValueSets = '1';
  String dropdownValueSubcategoria = 'Otros';

  final nombreEjerIngresado = TextEditingController();
  final descrip = TextEditingController();


  @override
  void initState(){
    super.initState();
    _referencePaciente = FirebaseFirestore.instance.collection('lista_pacientes').doc(widget.idPaciente);
    _referencePrograma = _referencePaciente.collection('programas').doc(widget.idPrograma);
    _referenceEjercicio = _referencePrograma.collection('ejercicios');
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
          title: const Text('Crear Ejercicio'),
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
                      controller: nombreEjerIngresado,
                      decoration: InputDecoration(
                        label: Text('Nombre'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.drive_file_rename_outline_rounded,
                          color: Colors.blue,
                        ),
                        hintText: 'Ingrese el nombre del ejercicio',
                      ),
                      validator: (String? value){
                        if(value==null || value.isEmpty) {
                          return 'Por favor ingrese el nombre del ejercicio';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      controller: descrip,
                      decoration: InputDecoration(
                        label: Text('Descripcion'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.blue,
                        ),
                        hintText: 'La descripcion del ejercicio',
                      ),
                      validator: (String? value){
                        if(value==null || value.isEmpty) {
                          return 'Por favor ingrese la descripcion del ejercicio';
                        }
                        return null;
                      },
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
                          dropdownValueCategoria = value!;
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
                        'Elegir la subcategoria'
                    ),
                    DropdownButtonFormField<String>(
                      value: dropdownValueSubcategoria,
                      onChanged: (String? value){
                        setState(() {
                          dropdownValueSubcategoria = value!;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          dropdownValueSubcategoria = value!;
                        });
                      },
                      items: items5.map<DropdownMenuItem<String>>(
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
                        'Elegir el numero de series'
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

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            String categoria = dropdownValueCategoria;
                            String descripcion = descrip.text;
                            String nombre = nombreEjerIngresado.text;
                            String repeticiones = dropdownValueRepeticiones;
                            String sets = dropdownValueSets;
                            String subcategoria = dropdownValueSubcategoria;
                            String tiempo = dropdownValueTiempo;


                            Map<String, dynamic> DatosEjercicio= {
                              'categoria': categoria,
                              'descripcion': descripcion,
                              'nombre': nombre,
                              'repeticiones': repeticiones,
                              'sets': sets,
                              'subcategoria': subcategoria,
                              'tiempo': tiempo,
                              'posteado' : FieldValue.serverTimestamp()
                            };
                            _referenceEjercicio.add(DatosEjercicio);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Ejercicio Creado!'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          'Haz creado un ejercicio'
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
                        child: Text('Crear Ejercicio'),
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