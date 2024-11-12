import 'package:flutter/material.dart';

class Ejercicio05 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicio 05',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF2E0054),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E0054), Color(0xFF00204A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ReajusteForm(),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _sueldoController,
            decoration: InputDecoration(
              labelText: 'Sueldo actual',
              labelStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.white10,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _antiguedadController,
            decoration: InputDecoration(
              labelText: 'Antigüedad (años)',
              labelStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.white10,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calcularReajuste,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2E0054), // Replaces 'primary'
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Calcular Reajuste',
              style: TextStyle(fontSize: 16),
            ),
          ),

          SizedBox(height: 20),
          FadeTransition(
            opacity: _fadeAnimation!,
            child: Text(
              _resultado,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
