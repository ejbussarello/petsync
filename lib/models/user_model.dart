class UserModel {
  final String uid;
  final String nome;
  final String sobrenome;
  final String email;

  UserModel({
    required this.uid,
    required this.nome,
    required this.sobrenome,
    required this.email,
  });

  // Converte os dados do Firestore para o Objeto
  factory UserModel.fromMap(Map<String, dynamic> data, String id) {
    return UserModel(
      uid: id,
      nome: data['nome'] ?? '',
      sobrenome: data['sobrenome'] ?? '',
      email: data['email'] ?? '',
    );
  }

  // Converte o Objeto para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
    };
  }
}