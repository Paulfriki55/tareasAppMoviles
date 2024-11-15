import 'package:flutter/material.dart';
import 'dart:math';

class Ejercicio03 extends StatefulWidget {
  @override
  _Ejercicio03State createState() => _Ejercicio03State();
}

class _Ejercicio03State extends State<Ejercicio03> {
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  final _cController = TextEditingController();
  String _resultado = '';

  void _calcularRaices() {
    final double? a = double.tryParse(_aController.text);
    final double? b = double.tryParse(_bController.text);
    final double? c = double.tryParse(_cController.text);

    if (a == null || b == null || c == null) {
      setState(() {
        _resultado = 'Por favor, ingrese valores válidos para A, B y C.';
      });
      return;
    }

    if (a == 0) {
      setState(() {
        _resultado = 'El valor de A no corresponde a una ecuación de segundo grado.';
      });
      return;
    }

    final double discriminante = pow(b, 2) - 4 * a * c;
    if (discriminante < 0) {
      setState(() {
        _resultado = 'La solución es imaginaria, ya que el discriminante es menor que 0.';
      });
    } else {
      final double raiz1 = (-b + sqrt(discriminante)) / (2 * a);
      final double raiz2 = (-b - sqrt(discriminante)) / (2 * a);
      setState(() {
        _resultado = 'Las raíces son:\nRaíz 1 = ${raiz1.toStringAsFixed(2)}\nRaíz 2 = ${raiz2.toStringAsFixed(2)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ejercicio 03',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.purple.shade800, // Cambio a purple
        centerTitle: true,
        elevation: 4,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Ecuación de Segundo Grado',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade800, // Cambio a purple
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ingrese los coeficientes A, B y C para calcular las raíces.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  _buildInputField(_aController, 'Coeficiente A'),
                  SizedBox(height: 10),
                  _buildInputField(_bController, 'Coeficiente B'),
                  SizedBox(height: 10),
                  _buildInputField(_cController, 'Coeficiente C'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _calcularRaices,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade700, // Cambio a purple
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 6,
                    ),
                    child: Text(
                      'Calcular Raíces',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_resultado.isNotEmpty)
                    Text(
                      _resultado,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade800, // Cambio a purple
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100, // Fondo claro y neutral
    );
  }

  Widget _buildInputField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.input, color: Colors.purple.shade600), // Cambio a purple
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple.shade700, width: 2), // Cambio a purple
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
