import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pagina_login.dart';
import 'pagina_home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Rest Flutter en Español',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isAuthenticated) {
            return PaginaHome();
          } else {
            return PaginaLogin();
          }
        },
      ),
      routes: {
        '/home': (context) => PaginaHome(),
      },
    );
  }
}

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _token = '';

  bool get isAuthenticated => _isAuthenticated;
  String get token => _token;

  void login(String token) {
    _isAuthenticated = true;
    _token = token;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _token = '';
    notifyListeners();
  }
}