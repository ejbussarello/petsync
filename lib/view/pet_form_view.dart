import 'package:flutter/material.dart';
import '../models/pet_model.dart';
import '../controllers/pet_controller.dart';

class PetFormView extends StatefulWidget {
  const PetFormView({super.key});

  @override
  State<PetFormView> createState() => _PetFormViewState();
}

class _PetFormViewState extends State<PetFormView> {
  final _formKey = GlobalKey<FormState>();
  final _petController = PetController();

  // Controllers dos campos
  final _nomeController = TextEditingController();
  final _racaController = TextEditingController();
  final _microchipController = TextEditingController();
  
  // Valores padrão para Dropdowns
  String _especie = 'Cão';
  String _sexo = 'Macho';
  String _porte = 'Médio';
  bool _isCastrado = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final novoPet = PetModel(
        tutorId: _petController.currentUserId,
        nome: _nomeController.text,
        especie: _especie,
        raca: _racaController.text,
        sexo: _sexo,
        dataNascimento: DateTime.now(), // Para simplificar, depois podemos por um DatePicker
        porte: _porte,
        isCastrado: _isCastrado,
        microchip: _microchipController.text,
      );

      bool sucesso = await _petController.savePet(novoPet);
      if (sucesso && mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pet cadastrado com sucesso!")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(title: const Text("Novo Pet"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildSectionTitle("Identificação Básica"),
              _buildInputCard([
                _buildTextField(_nomeController, "Nome do Pet", Icons.pets),
                const SizedBox(height: 15),
                _buildDropdown("Espécie", ['Cão', 'Gato', 'Ave', 'Outro'], (val) => setState(() => _especie = val!)),
              ]),
              const SizedBox(height: 20),
              _buildSectionTitle("Características"),
              _buildInputCard([
                _buildTextField(_racaController, "Raça", Icons.category_outlined),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(child: _buildDropdown("Sexo", ['Macho', 'Fêmea'], (val) => setState(() => _sexo = val!))),
                    const SizedBox(width: 10),
                    Expanded(child: _buildDropdown("Porte", ['Pequeno', 'Médio', 'Grande'], (val) => setState(() => _porte = val!))),
                  ],
                ),
              ]),
              const SizedBox(height: 20),
              _buildSectionTitle("Saúde e Segurança"),
              _buildInputCard([
                SwitchListTile(
                  title: const Text("Animal Castrado?"),
                  value: _isCastrado,
                  activeColor: Colors.blueAccent,
                  onChanged: (val) => setState(() => _isCastrado = val),
                ),
                _buildTextField(_microchipController, "Número do Microchip (opcional)", Icons.qr_code_scanner),
              ]),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("Salvar Pet", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widgets Auxiliares para manter o design CLEAN
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5),
      child: Align(alignment: Alignment.centerLeft, child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey))),
    );
  }

  Widget _buildInputCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
      ),
      validator: (val) => val!.isEmpty ? "Campo obrigatório" : null,
    );
  }

  Widget _buildDropdown(String label, List<String> items, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: items[0],
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
  }
}