import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirmPass = TextEditingController();
  final _auth = AuthService();
  bool _loading = false;
  bool _showPass = false;
  bool _showConfirm = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE0B2), Color(0xFFFFCC80)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'GymFitApp',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tu gimnasio inteligente, siempre contigo',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Crea tu cuenta',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _name,
                    decoration: const InputDecoration(
                      labelText: 'Nombre completo',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _pass,
                    obscureText: !_showPass,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_showPass ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _showPass = !_showPass),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _confirmPass,
                    obscureText: !_showConfirm,
                    decoration: InputDecoration(
                      labelText: 'Confirmar contraseña',
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_showConfirm ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _showConfirm = !_showConfirm),
                      ),
                    ),
                  ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(_error!, style: const TextStyle(color: Colors.red)),
                    ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 216, 149, 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _loading ? null : _register,
                      child: _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Registrar cuenta'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: _navigateBack,
                      child: const Text('¿Ya tienes cuenta? Inicia sesión'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateBack() {
    Navigator.pop(context);
  }

  Future<void> _register() async {
    if (_name.text.isEmpty || _email.text.isEmpty || _pass.text.isEmpty) {
      setState(() => _error = 'Completa todos los campos');
      return;
    }
    if (_pass.text != _confirmPass.text) {
      setState(() => _error = 'Las contraseñas no coinciden');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final user = await _auth.register(_name.text.trim(), _email.text.trim(), _pass.text);
      if (!mounted) return;
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Error al registrar: ${e.toString()}');
    }

    if (!mounted) return;
    setState(() => _loading = false);
  }
}