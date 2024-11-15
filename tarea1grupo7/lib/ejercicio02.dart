import 'package:flutter/material.dart';

class Ejercicio02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ejercicio 02',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.purple.shade800, // Cambio a purple
        centerTitle: true,
        elevation: 4,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: CamisasForm(),
        ),
      ),
      backgroundColor: Colors.grey.shade100, // Fondo claro y neutral
    );
  }
}

class CamisasForm extends StatefulWidget {
  @override
  _CamisasFormState createState() => _CamisasFormState();
}

class _CamisasFormState extends State<CamisasForm> {
  final _cantidadController = TextEditingController();
  String _resultado = '';
  final _formKey = GlobalKey<FormState>();

  void _calcularCosto() {
    if (_formKey.currentState!.validate()) {
      final int cantidad = int.tryParse(_cantidadController.text) ?? 0;

      // Precios según la cantidad
      const double precioDescuento = 4000;
      const double precioNormal = 4800;
      double costoTotal = 0;

      if (cantidad > 3) {
        costoTotal = cantidad * precioDescuento;
      } else {
        costoTotal = cantidad * precioNormal;
      }

      setState(() {
        _resultado = 'Costo Total: \$${costoTotal.toStringAsFixed(2)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        elevation: 6,
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
                'Calcular Costo de Camisas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800, // Cambio a purple
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _cantidadController,
                decoration: InputDecoration(
                  labelText: 'Cantidad de camisas',
                  prefixIcon: Icon(Icons.shopping_cart, color: Colors.purple.shade600), // Cambio a purple
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
                    return 'Por favor ingresa la cantidad de camisas';
                  }
                  final int? cantidad = int.tryParse(value);
                  if (cantidad == null || cantidad <= 0) {
                    return 'Por favor ingresa una cantidad válida mayor a 0';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularCosto,
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
                  'Calcular Costo',
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
}
