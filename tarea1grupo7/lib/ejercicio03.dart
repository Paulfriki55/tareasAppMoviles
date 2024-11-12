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
        _resultado = 'La solución es imaginaria ya que el discriminante es menor que 0.';
      });
    } else {
      final double raiz1 = (-b + sqrt(discriminante)) / (2 * a);
      final double raiz2 = (-b - sqrt(discriminante)) / (2 * a);
      setState(() {
        _resultado = 'Las raíces son:\nRaíz 1 = $raiz1\nRaíz 2 = $raiz2';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicio 03 - Raíces de Ecuación Cuadrática'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _aController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Ingrese el coeficiente A'),
            ),
            TextField(
              controller: _bController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Ingrese el coeficiente B'),
            ),
            TextField(
              controller: _cController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Ingrese el coeficiente C'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularRaices,
              child: Text('Calcular Raíces'),
            ),
            SizedBox(height: 20),
            Text(
              _resultado,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
