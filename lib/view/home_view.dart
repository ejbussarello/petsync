import 'package:flutter/material.dart';
import 'package:petsync/controllers/pet_controller.dart';
import 'package:petsync/models/pet_model.dart';
import 'package:petsync/models/user_model.dart';
import 'package:petsync/view/pet_form_view.dart';
import 'package:petsync/widgets/pet_card.dart';
import '../controllers/auth_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  // No topo da classe HomeView, instancie o PetController
  final _petController = PetController();

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("PetSync", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueGrey,
      ),
      // Drawer (Menu Lateral)
      drawer: Drawer(
        child: FutureBuilder<UserModel?>(
          future: authController.getUserData(), // Chama o método que criámos
          builder: (context, snapshot) {
            // Enquanto carrega, podemos mostrar um indicador de progresso ou dados vazios
            String nomeExibicao = "Carregando...";
            String emailExibicao = "...";

            if (snapshot.hasData && snapshot.data != null) {
              nomeExibicao = "${snapshot.data!.nome} ${snapshot.data!.sobrenome}";
              emailExibicao = snapshot.data!.email;
            }

            return Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.blueAccent),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      nomeExibicao.isNotEmpty ? nomeExibicao[0].toUpperCase() : "P",
                      style: const TextStyle(fontSize: 24, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    ),
                  ),
                  accountName: Text(nomeExibicao, style: const TextStyle(fontWeight: FontWeight.bold)),
                  accountEmail: Text(emailExibicao),
                ),
                ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: const Text("Início"),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.pets_outlined),
                  title: const Text("Meus Pets"),
                  onTap: () {},
                ),
                const Spacer(),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text("Sair", style: TextStyle(color: Colors.redAccent)),
                  onTap: () async {
                    await authController.logout();
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
      // No build do Scaffold
body: StreamBuilder<List<PetModel>>(
  stream: _petController.getMyPets(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pets_outlined, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text("Nenhum pet cadastrado ainda.", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    final pets = snapshot.data!;

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: pets.length,
      itemBuilder: (context, index) {
        return PetCard(pet: pets[index]);
      },
    );
  },
),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PetFormView()),
          );
        },
      ),
    );
  }
}