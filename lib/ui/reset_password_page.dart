import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _email = TextEditingController();
  final _newPass = TextEditingController();
  final _confirmPass = TextEditingController();
  final _auth = AuthService();
  String? _msg;
  String? _error;
  bool _loading = false;

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
                children: [
                  const Text(
                    'Recuperar contraseña',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  _inputField(_email, 'Correo electronico'),
                  const SizedBox(height: 16),
                  _inputField(_newPass, 'Nueva contraseña', obscure: true),
                  const SizedBox(height: 16),
                  _inputField(_confirmPass, 'Confirmar nueva contraseña', obscure: true),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(_error!, style: const TextStyle(color: Colors.red)),
                    ),
                  if (_msg != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(_msg!, style: const TextStyle(color: Colors.green)),
                    ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF8D6E63),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      onPressed: _loading
                          ? null
                          : () async {
                              if (_newPass.text != _confirmPass.text) {
                                setState(() => _error = 'Las contraseñas no coinciden');
                                return;
                              }
                              setState(() {
                                _loading = true;
                                _error = null;
                                _msg = null;
                              });
                              try {
                                await _auth.resetPassword(_email.text.trim());
                                setState(() => _msg = 'Te enviamos un enlace de recuperación');
                              } catch (e) {
                                setState(() => _error = 'No fue posible enviar el enlace');
                              }
                              setState(() => _loading = false);
                            },
                      child: _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Actualizar contraseña',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
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

  Widget _inputField(TextEditingController controller, String label, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}