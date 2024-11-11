import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ejercicio01.dart';
import 'ejercicio02.dart';
import 'ejercicio03.dart';
import 'ejercicio04.dart';
import 'ejercicio05.dart';
import 'ejercicio06.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESPE Mobile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Moviles - Tarea 1.1',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF2E0054),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'img/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 20),
                  _buildCardSection(_buildCourseInfo()),
                  SizedBox(height: 20),
                  _buildCardSection(_buildTeamInfo()),
                  SizedBox(height: 20),
                  _buildExercisesButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Color(0xFF2E0054), Color(0xFF00204A)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🏛️ UNIVERSIDAD DE LAS FUERZAS ARMADAS ESPE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            '📚 Departamento de Ciencias de la Computación\n👨‍💻 Carrera de Software',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSection(Widget child) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  Widget _buildCourseInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '📱 Desarrollo de Aplicaciones Móviles',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2E0054)),
        ),
        SizedBox(height: 8),
        Text('📝 NRC: 2509', style: TextStyle(fontSize: 16, color: Colors.grey[800])),
        SizedBox(height: 8),
        Text(
          '🧑‍💻 Tema: Creación y ejecución de una Activity',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildTeamInfo() {
    String formattedDate = "${DateTime.now().day} de ${_getMonthName(DateTime.now().month)} del ${DateTime.now().year}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '👥 Integrantes:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2E0054)),
        ),
        SizedBox(height: 8),
        Text(
          '🎓 Almeida Marlyn\n🎓 Pullaguari Axel\n🎓 Sánchez Paúl',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        Text(
          '👩‍🏫 Docente: Ing. Dorys Chicaiza',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        SizedBox(height: 8),
        Text(
          '📅 Fecha: $formattedDate',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return months[month - 1];
  }

  Widget _buildExercisesButton(BuildContext context) {
    return Center(
      child: MouseRegion(
        onEnter: (_) => print("Hover!"),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2E0054),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => _buildExercisesModal(context),
            );
          },
          child: Text(
            '🎯 Ver Ejercicios',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildExercisesModal(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 16),
            Text(
              '⚡ Seleccione un ejercicio',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E0054),
              ),
            ),
            SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                padding: EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (context, index) {
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        final exercise = switch (index) {
                          0 => Ejercicio01(),
                          1 => Ejercicio02(),
                          2 => Ejercicio03(),
                          3 => Ejercicio04(),
                          4 => Ejercicio05(),
                          5 => Ejercicio06(),
                          _ => Ejercicio01(),
                        };

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => exercise),
                        );
                      },
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2E0054),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        '📖 Ejercicio ${(index + 1).toString().padLeft(2, '0')}',
                        style: TextStyle(color: Color(0xFF2E0054)),
                      ),
                      trailing: Icon(Icons.chevron_right, color: Color(0xFF2E0054)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
