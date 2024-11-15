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
        title: Text('Ejercicio 04',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Determinar Tipo de Triángulo',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ingrese las longitudes de los lados para determinar el tipo de triángulo.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  _buildInputField(_lado1Controller, 'Lado 1'),
                  SizedBox(height: 10),
                  _buildInputField(_lado2Controller, 'Lado 2'),
                  SizedBox(height: 10),
                  _buildInputField(_lado3Controller, 'Lado 3'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _determinarTriangulo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text('Determinar Tipo de Triángulo',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _resultado,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.straighten),
      ),
    );
  }
}
