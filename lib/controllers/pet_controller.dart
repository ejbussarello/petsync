import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/pet_model.dart';

class PetController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> savePet(PetModel pet) async {
    try {
      await _db.collection('pets').add(pet.toMap());
      return true;
    } catch (e) {
      print("Erro ao salvar pet: $e");
      return false;
    }
  }
  String get currentUserId => _auth.currentUser?.uid ?? "";
  // Retorna um Stream para que a lista atualize em tempo real quando um pet for adicionado
  Stream<List<PetModel>> getMyPets() {
    return _db
        .collection('pets')
        .where('tutorId', isEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PetModel.fromMap(doc.data(), doc.id))
            .toList());
  }
}