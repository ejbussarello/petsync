import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Registrar Usuário
  Future<String?> register({
    required String email,
    required String password,
    required String nome,
    required String sobrenome,
  }) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      UserModel newUser = UserModel(
        uid: res.user!.uid,
        nome: nome,
        sobrenome: sobrenome,
        email: email,
      );

      await _db.collection('users').doc(res.user!.uid).set(newUser.toMap());
      return null; // Sucesso
    } on FirebaseAuthException catch (e) {
      return e.message; // Retorna o erro do Firebase
    }
  }

  // Login
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Adicione este método dentro da classe AuthController
Future<UserModel?> getUserData() async {
  try {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot doc = await _db.collection('users').doc(currentUser.uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
    }
  } catch (e) {
    print("Erro ao buscar dados do utilizador: $e");
  }
  return null;
}
}