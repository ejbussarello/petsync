import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = AuthController();
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Por favor, preencha todos os campos.");
      setState(() => _isLoading = false);
      return;
    }

    String? error = await _authController.login(email, password);

    if (error == null) {
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showSnackBar("Erro ao entrar: $error");
    }

    if (mounted) setState(() => _isLoading = false);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                // Logo Flutuante
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
                  ),
                  child: const Icon(Icons.pets, size: 60, color: Colors.blueAccent),
                ),
                const SizedBox(height: 40),
                
                // Card de Login
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 30)],
                  ),
                  child: Column(
                    children: [
                      const Text("PetSync", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                      const SizedBox(height: 30),
                      _buildTextField(_emailController, "E-mail", Icons.email_outlined),
                      const SizedBox(height: 20),
                      _buildTextField(_passwordController, "Senha", Icons.lock_outline, isPass: true),
                      const SizedBox(height: 30),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: _isLoading 
                            ? const CircularProgressIndicator(color: Colors.white) 
                            : const Text("Entrar", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text("Não tem conta? Crie uma aqui", style: TextStyle(color: Colors.blueGrey)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPass = false}) {
    return TextField(
      controller: controller,
      obscureText: isPass,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }
}