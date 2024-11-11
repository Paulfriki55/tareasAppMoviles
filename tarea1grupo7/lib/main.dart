import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'ejercicio01.dart';
import 'ejercicio02.dart';
import 'ejercicio03.dart';
import 'ejercicio04.dart';
import 'ejercicio05.dart';
import 'ejercicio06.dart';
import 'ejercicio07.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESPE Mobile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.blue.shade900],
          ),
        ),
        child: SafeArea(
          child: AnimationLimiter(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      _buildHeader(),
                      SizedBox(height: 20),
                      _buildInfoSection(),
                      SizedBox(height: 30),
                      _buildDropdownMenu(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Text(
              'UNIVERSIDAD DE LAS FUERZAS ARMADAS ESPE',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Departamento de Ciencias de la Computación\nCarrera de Software',
              style: TextStyle(fontSize: 18, color: Colors.blue.shade700),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Desarrollo de Aplicaciones Móviles\nNRC: 2509',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Tema: Creación y ejecución de una Activity',
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.blue.shade700),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Text('Integrantes:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
            Text('• Almeida Marlyn\n• Pullaguari Axel\n• Sánchez Paúl', style: TextStyle(fontSize: 16, color: Colors.blue.shade700)),
            SizedBox(height: 10),
            Text('Docente: Ing. Dorys Chicaiza', style: TextStyle(fontSize: 16, color: Colors.blue.shade700)),
            Text('Fecha: 14 de Noviembre del 2024', style: TextStyle(fontSize: 16, color: Colors.blue.shade700)),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownMenu(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: DropdownButton<String>(
            hint: Text('Seleccione un ejercicio', style: TextStyle(color: Colors.blue.shade900)),
            icon: Icon(Icons.arrow_drop_down, color: Colors.blue.shade900),
            dropdownColor: Colors.blue.shade50,
            items: [
              'Ejercicio 01',
              'Ejercicio 02',
              'Ejercicio 03',
              'Ejercicio 04',
              'Ejercicio 05',
              'Ejercicio 06',
              'Ejercicio 07'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.blue.shade700)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                switch (newValue) {
                  case 'Ejercicio 01':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Ejercicio01()));
                    break;
                  case 'Ejercicio 02':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Ejercicio02()));
                    break;
                  case 'Ejercicio 03':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Ejercicio03()));
                    break;
                  case 'Ejercicio 04':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Ejercicio04()));
                    break;
                  case 'Ejercicio 05':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Ejercicio05()));
                    break;
                  case 'Ejercicio 06':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Ejercicio06()));
                    break;
                  case 'Ejercicio 07':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Ejercicio07()));
                    break;
                }
              }
            },
          ),
        ),
      ),
    );
  }
}