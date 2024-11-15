import 'package:flutter/material.dart';

class Ejercicio05 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ejercicio 05',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple, // Color del encabezado
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        color: Colors.white, // Fondo blanco
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white, // Fondo blanco para la tarjeta
              child: Padding(
                padding: EdgeInsets.all(20),
                child: ReajusteForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReajusteForm extends StatefulWidget {
  @override
  _ReajusteFormState createState() => _ReajusteFormState();
}

class _ReajusteFormState extends State<ReajusteForm> with SingleTickerProviderStateMixin {
  final _sueldoController = TextEditingController();
  final _antiguedadController = TextEditingController();
  String _resultado = '';
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    );
  }

  void _calcularReajuste() {
    final double sueldo = double.tryParse(_sueldoController.text) ?? 0;
    final int antiguedad = int.tryParse(_antiguedadController.text) ?? 0;
    double reajuste = 0;

    if (antiguedad < 10) {
      if (sueldo <= 300000) {
        reajuste = 0.12;
      } else if (sueldo > 300000 && sueldo <= 500000) {
        reajuste = 0.10;
      } else if (sueldo > 500000) {
        reajuste = 0.08;
      }
    } else if (antiguedad >= 10 && antiguedad < 20) {
      if (sueldo <= 300000) {
        reajuste = 0.14;
      } else if (sueldo > 300000 && sueldo <= 500000) {
        reajuste = 0.12;
      } else if (sueldo > 500000) {
        reajuste = 0.10;
      }
    } else if (antiguedad >= 20) {
      reajuste = 0.15;
    }

    final double nuevoSueldo = sueldo + (sueldo * reajuste);
    setState(() {
      _resultado = 'Nuevo sueldo: \$${nuevoSueldo.toStringAsFixed(2)}';
    });

    _animationController!.forward(from: 0); // Inicia la animación
  }

  @override
  void dispose() {
    _sueldoController.dispose();
    _antiguedadController.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Reajuste de Sueldos',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        _buildTextField(
          controller: _sueldoController,
          label: 'Sueldo actual',
          icon: Icons.attach_money,
        ),
        SizedBox(height: 20),
        _buildTextField(
          controller: _antiguedadController,
          label: 'Antigüedad (años)',
          icon: Icons.calendar_today,
        ),
        SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: _calcularReajuste,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple, // Color del botón
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: Icon(Icons.calculate, color: Colors.white),
          label: Text(
            'Calcular Reajuste',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        SizedBox(height: 30),
        FadeTransition(
          opacity: _fadeAnimation!,
          child: Center(
            child: Text(
              _resultado,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal),
        labelStyle: TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.black),
    );
  }
}
