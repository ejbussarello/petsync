import 'package:flutter/material.dart';
import '../models/pet_model.dart';

class PetCard extends StatelessWidget {
  final PetModel pet;
  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar Circular com a inicial ou ícone da espécie
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: pet.especie == 'Cão' ? Colors.orange[50] : Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              pet.especie == 'Cão' ? Icons.pets : Icons.pest_control_rodent,
              color: pet.especie == 'Cão' ? Colors.orange : Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          // Informações do Pet
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.nome,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
                Text(
                  "${pet.raca} • ${pet.porte}",
                  style: TextStyle(color: Colors.blueGrey.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          // Tag de Gênero
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: pet.sexo == 'Macho' ? Colors.blue[50] : Colors.pink[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              pet.sexo,
              style: TextStyle(
                color: pet.sexo == 'Macho' ? Colors.blue : Colors.pink,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}