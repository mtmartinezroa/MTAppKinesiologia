import 'package:flutter/cupertino.dart';
import 'package:mt_app_kinesiologia/clasesextra/ejercicios.dart';
import 'programas.dart';

class programasData extends ChangeNotifier{

  List<Programas> listaProgramas = [
    Programas(
      nombre: "Pierna",
      ejercicios: [
        Ejercicios(
            nombre: "Sentadilla",
            repeticiones: "4",
            tiempo: "3",
            sets: "2",
            descripcion: "dar flexiones con la pierna y luego dar pequeños saltos y caminar por 2 minutos",
            categoria: "plexo solar",
        ),
      ],
      descripcion: "Este ejercicio consiste en hacer flexiones",
    )
  ];

  List<Programas> getListaProgramas(){  //lista de programas
    return listaProgramas;
  }

  int numeroEjerciciosPrograma(String nombrePrograma){ // la cantidad de ejercicios en el programa
    Programas programaActual = getProgramaActual(nombrePrograma);
    return programaActual.ejercicios.length;
  }

  void agregarPrograma(String nombre, String descripcion){  //añadir programa
    listaProgramas.add(Programas(nombre: nombre, ejercicios: [],descripcion: descripcion ));
    notifyListeners();
  }

  void agregarEjercicio(
      String nombrePrograma,
      String nombreEjercicio,
      String repeticiones,
      String tiempo,
      String sets,
      String descripcion,
      String categoria
      ){ //añadir ejercicio a programa
    Programas programaActual = getProgramaActual(nombrePrograma);
    programaActual.ejercicios.add(
      Ejercicios(
          nombre: nombreEjercicio,
          repeticiones: repeticiones,
          tiempo: tiempo,
          sets: sets,
          descripcion: descripcion,
          categoria: categoria
          ),
      );
    notifyListeners();
  }

  void revisarEjercicioCompletado(String nombrePrograma, String nombreEjercicio){ // para controlar si el ejercicio se completo o no
    Ejercicios ejercicioActual = getEjercicioActual(nombrePrograma, nombreEjercicio);
    ejercicioActual.ECompletado = !ejercicioActual.ECompletado;
    notifyListeners();
  }

  Programas getProgramaActual(String nombrePrograma){ //devuelve el programa actual para saber con cual programa estamos trabajando
    Programas programaActual =
        listaProgramas.firstWhere((programa) => programa.nombre == nombrePrograma);
    return programaActual;
  }

  Ejercicios getEjercicioActual(String nombrePrograma, String nombreEjercicio){ // devuelve el ejercicio actual para saber con cual ejercicio estamos trabajando
    Programas programaActual = getProgramaActual(nombrePrograma);
    Ejercicios ejercicioActual =
        programaActual.ejercicios.firstWhere((ejercicio) => ejercicio.nombre == nombreEjercicio);
    return ejercicioActual;
  }
}