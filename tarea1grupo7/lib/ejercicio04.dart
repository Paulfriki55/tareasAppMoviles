import 'package:flutter/material.dart';

class Ejercicio04 extends StatefulWidget {
  @override
  _Ejercicio04State createState() => _Ejercicio04State();
}

class _Ejercicio04State extends State<Ejercicio04> {
  final _lado1Controller = TextEditingController();
  final _lado2Controller = TextEditingController();
  final _lado3Controller = TextEditingController();
  String _resultado = '';

  void _determinarTriangulo() {
    setState(() {
      final double? l1 = double.tryParse(_lado1Controller.text);
      final double? l2 = double.tryParse(_lado2Controller.text);
      final double? l3 = double.tryParse(_lado3Controller.text);

      if (l1 == null || l2 == null || l3 == null || l1 <= 0 || l2 <= 0 || l3 <= 0) {
        _resultado = 'Por favor, ingrese valores válidos y positivos para los lados.';
        return;
      }

      if (l1 + l2 > l3 && l1 + l3 > l2 && l2 + l3 > l1) {
        if (l1 == l2 && l2 == l3) {
          _resultado = 'Los lados forman un triángulo equilátero.';
        } else if (l1 == l2 || l1 == l3 || l2 == l3) {
          _resultado = 'Los lados forman un triángulo isósceles.';
        } else {
          _resultado = 'Los lados forman un triángulo escaleno.';
        }
      } else {
        _resultado = 'Los lados no forman un triángulo.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicio 04 - Tipos de Triángulo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _lado1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Ingrese el lado 1'),
            ),
            TextField(
              controller: _lado2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Ingrese el lado 2'),
            ),
            TextField(
              controller: _lado3Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Ingrese el lado 3'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _determinarTriangulo,
              child: Text('Determinar Tipo de Triángulo'),
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
