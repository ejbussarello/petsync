class PetModel {
  final String? id;
  final String tutorId;
  final String nome;
  final String especie;
  final String raca;
  final String sexo;
  final String porte;
  final bool isCastrado;
  final String? microchip;
  final DateTime dataNascimento; // <-- Reincluído

  PetModel({
    this.id,
    required this.tutorId,
    required this.nome,
    required this.especie,
    required this.raca,
    required this.sexo,
    required this.porte,
    required this.isCastrado,
    required this.dataNascimento, // <-- Reincluído
    this.microchip,
  });

  factory PetModel.fromMap(Map<String, dynamic> map, String id) {
    return PetModel(
      id: id,
      tutorId: map['tutorId'] ?? '',
      nome: map['nome'] ?? '',
      especie: map['especie'] ?? 'Cão',
      raca: map['raca'] ?? '',
      sexo: map['sexo'] ?? 'Macho',
      porte: map['porte'] ?? 'Médio',
      isCastrado: map['isCastrado'] ?? false,
      microchip: map['microchip'],
      // Converte a String do banco de volta para DateTime
      dataNascimento: map['dataNascimento'] != null 
          ? DateTime.parse(map['dataNascimento']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tutorId': tutorId,
      'nome': nome,
      'especie': especie,
      'raca': raca,
      'sexo': sexo,
      'porte': porte,
      'isCastrado': isCastrado,
      'microchip': microchip,
      'dataNascimento': dataNascimento.toIso8601String(), // <-- Salva como String
    };
  }
}