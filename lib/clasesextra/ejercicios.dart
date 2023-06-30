class Ejercicios{
  final String nombre; // tipo de musculos , ejercicios ,clasificacion
  final String repeticiones;
  final String tiempo;
  final String sets;
  final String descripcion;
  final String categoria;
  bool ECompletado;

  Ejercicios({
    required this.nombre,
    required this.repeticiones,
    required this.tiempo,
    required this.sets,
    required this.descripcion,
    required this.categoria,
    this.ECompletado = false,
  });
}