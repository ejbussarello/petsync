import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authController = AuthController();

  void _handleRegister() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Senhas não conferem")));
      return;
    }

    String? error = await _authController.register(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      nome: _nomeController.text.trim(),
      sobrenome: _sobrenomeController.text.trim(),
    );

    if (error == null) {
      if (mounted) Navigator.pop(context); // Volta para o login
    } else {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.blueAccent)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              children: [
                const Text("Criar Conta no PetSync", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                const SizedBox(height: 30),
                _buildField(_nomeController, "Nome", Icons.person_outline),
                const SizedBox(height: 15),
                _buildField(_sobrenomeController, "Sobrenome", Icons.person_outline),
                const SizedBox(height: 15),
                _buildField(_emailController, "E-mail", Icons.email_outlined),
                const SizedBox(height: 15),
                _buildField(_passwordController, "Senha", Icons.lock_outline, isPass: true),
                const SizedBox(height: 15),
                _buildField(_confirmPasswordController, "Confirmar Senha", Icons.lock_reset, isPass: true),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("Salvar Cadastro", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, IconData icon, {bool isPass = false}) {
    return TextField(
      controller: controller,
      obscureText: isPass,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }
}