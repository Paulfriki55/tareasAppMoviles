import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaginaRegister extends StatefulWidget {
  @override
  _PaginaRegisterState createState() => _PaginaRegisterState();
}

class _PaginaRegisterState extends State<PaginaRegister> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final response = await http.post(
          Uri.parse('http://10.0.2.2/api_usuarios/register.php'),
          body: json.encode({
            'email': _emailController.text,
            'password': _passwordController.text,
            'nombre': _nombreController.text,
            'apellido': _apellidoController.text,
            'telefono': _telefonoController.text,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 201) {
          _showSnackBar('Registro exitoso. Por favor, inicia sesión.');
          Navigator.pop(context);
        } else {
          _showSnackBar('Registro fallido. Por favor, inténtalo de nuevo.', isError: true);
        }
      } catch (e) {
        _showSnackBar('Ocurrió un error. Por favor, inténtalo más tarde.', isError: true);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: 'registerIcon',
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: Icon(
                        Icons.person_add,
                        size: 60,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Crea tu cuenta',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Correo electrónico',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu correo electrónico';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Ingresa un correo electrónico válido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Contraseña',
                    icon: Icons.lock,
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu contraseña';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: _nombreController,
                    label: 'Nombre',
                    icon: Icons.person,
                    validator: (value) => value!.isEmpty ? 'Por favor, ingresa tu nombre' : null,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: _apellidoController,
                    label: 'Apellido',
                    icon: Icons.person,
                    validator: (value) => value!.isEmpty ? 'Por favor, ingresa tu apellido' : null,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    controller: _telefonoController,
                    label: 'Teléfono',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty ? 'Por favor, ingresa tu número de teléfono' : null,
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    child: _isLoading
                        ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : Text('Registrarse'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('¿Ya tienes una cuenta? Inicia sesión'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
    );
  }
}