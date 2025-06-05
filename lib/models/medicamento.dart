class Medicamento {
  final int? id;
  final String nombre;
  final String dosis;
  final String cantidad;
  final String inicio;
  
  final String fin;
  final String fechaToma; 
  final String horaToma;

  Medicamento({
    this.id,
    required this.nombre,
    required this.dosis,
    required this.cantidad,
    required this.inicio,
    required this.fin,
    required this.fechaToma,
    required this.horaToma,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'dosis': dosis,
      'cantidad': cantidad,
      'inicio': inicio,
      'fin': fin,
      'fechaToma': fechaToma,
      'horaToma': horaToma,
    };
  }

  factory Medicamento.fromMap(Map<String, dynamic> map) {
    return Medicamento(
      id: map['id'],
      nombre: map['nombre'],
      dosis: map['dosis'],
      cantidad: map['cantidad'],
      inicio: map['inicio'],
      fin: map['fin'],
      fechaToma: map['fechaToma'],
      horaToma: map['horaToma'],
    );
  }
}