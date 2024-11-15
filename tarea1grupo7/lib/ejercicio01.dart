import 'package:flutter/material.dart';

class Ejercicio01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ejercicio 01',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.purple.shade800, // Cambio a purple
        centerTitle: true,
        elevation: 4, // Elevación ligera para dar profundidad
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: OrdenarNumerosForm(),
        ),
      ),
      backgroundColor: Colors.grey.shade100, // Fondo claro y neutral
    );
  }
}

class OrdenarNumerosForm extends StatefulWidget {
  @override
  _OrdenarNumerosFormState createState() => _OrdenarNumerosFormState();
}

class _OrdenarNumerosFormState extends State<OrdenarNumerosForm> {
  final _num1Controller = TextEditingController();
  final _num2Controller = TextEditingController();
  final _num3Controller = TextEditingController();
  String _resultado = '';
  final _formKey = GlobalKey<FormState>();

  void _ordenarNumeros() {
    if (_formKey.currentState!.validate()) {
      final double num1 = double.tryParse(_num1Controller.text) ?? 0;
      final double num2 = double.tryParse(_num2Controller.text) ?? 0;
      final double num3 = double.tryParse(_num3Controller.text) ?? 0;

      // Ordenar los números usando una lista
      List<double> numeros = [num1, num2, num3];
      numeros.sort();

      setState(() {
        _resultado = 'Números ordenados: ${numeros.join(', ')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ordenar Números en Ascendente',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800, // Cambio a purple
                ),
              ),
              SizedBox(height: 24),
              _buildTextFormField(_num1Controller, 'Número 1', Icons.filter_1),
              SizedBox(height: 16),
              _buildTextFormField(_num2Controller, 'Número 2', Icons.filter_2),
              SizedBox(height: 16),
              _buildTextFormField(_num3Controller, 'Número 3', Icons.filter_3),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _ordenarNumeros,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade700, // Cambio a purple
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 6,
                ),
                child: Text(
                  'Ordenar Números',
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
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade800, // Cambio a purple
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.purple.shade600), // Cambio a purple
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
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa un número válido';
        }
        if (double.tryParse(value) == null) {
          return 'Por favor ingresa un valor numérico válido';
        }
        return null;
      },
    );
  }
}
