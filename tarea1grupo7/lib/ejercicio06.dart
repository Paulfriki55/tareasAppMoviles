import 'package:flutter/material.dart';

class Ejercicio06 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ejercicio 06',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple, // Color del encabezado
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        color: Colors.white, // Fondo blanco
        child: Center(
          child: SueldoForm(),
        ),
      ),
    );
  }
}

class SueldoForm extends StatefulWidget {
  @override
  _SueldoFormState createState() => _SueldoFormState();
}

class _SueldoFormState extends State<SueldoForm> {
  final _sueldoBaseController = TextEditingController();
  final _horasNormalesController = TextEditingController();
  final _horasNocturnasController = TextEditingController();
  String _resultado = '';
  bool _hovering = false;

  void _calcularSueldoSemanal() {
    final double sueldoBase = double.tryParse(_sueldoBaseController.text) ?? 0;
    final int horasNormales = int.tryParse(_horasNormalesController.text) ?? 0;
    final int horasNocturnas = int.tryParse(_horasNocturnasController.text) ?? 0;

    const double valorHoraNormal = 2000;
    final double valorHoraNocturna = valorHoraNormal * 1.3;

    final double valorExtrasNormales = horasNormales * valorHoraNormal;
    final double valorExtrasNocturnas = horasNocturnas * valorHoraNocturna;
    final double sueldoSemanal = sueldoBase + valorExtrasNormales + valorExtrasNocturnas;

    setState(() {
      _resultado = 'Sueldo semanal: \$${sueldoSemanal.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTextField(_sueldoBaseController, 'Sueldo base'),
          SizedBox(height: 15),
          _buildTextField(_horasNormalesController, 'Horas extras normales'),
          SizedBox(height: 15),
          _buildTextField(_horasNocturnasController, 'Horas extras nocturnas'),
          SizedBox(height: 25),
          MouseRegion(
            onEnter: (_) => setState(() => _hovering = true),
            onExit: (_) => setState(() => _hovering = false),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              transform: Matrix4.identity()..scale(_hovering ? 1.05 : 1.0),
              child: ElevatedButton(
                onPressed: _calcularSueldoSemanal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _hovering ? Colors.deepPurple: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: _hovering ? 15 : 5,
                  shadowColor: Color(0xFF2E0054),
                ),
                child: Text(
                  'Calcular Sueldo Semanal',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          AnimatedOpacity(
            opacity: _resultado.isNotEmpty ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Text(
              _resultado,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }
}
