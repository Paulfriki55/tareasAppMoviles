import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'main.dart';

class PaginaHome extends StatefulWidget {
  @override
  _PaginaHomeState createState() => _PaginaHomeState();
}

class _PaginaHomeState extends State<PaginaHome> {
  Map<String, dynamic> _userData = {};
  bool _isEditing = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() => _isLoading = true);

    final token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1/api_usuarios/user_crud.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() => _userData = json.decode(response.body));
      } else {
        _showSnackBar('Error al obtener los datos del usuario', isError: true);
      }
    } catch (e) {
      _showSnackBar('Ocurrió un error. Por favor, inténtalo más tarde.', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateUserData() async {
    setState(() => _isLoading = true);

    final token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      final response = await http.put(
        Uri.parse('http://127.0.0.1/api_usuarios/user_crud.php'),
        body: json.encode(_userData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _showSnackBar('Datos del usuario actualizados con éxito');
        setState(() => _isEditing = false);
        _fetchUserData();
      } else {
        _showSnackBar('Error al actualizar los datos del usuario', isError: true);
      }
    } catch (e) {
      _showSnackBar('Ocurrió un error. Por favor, inténtalo más tarde.', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              SizedBox(height: 24),
              _isEditing ? _buildEditForm() : _buildUserInfo(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _isEditing = !_isEditing),
        child: Icon(_isEditing ? Icons.save : Icons.edit),
        tooltip: _isEditing ? 'Guardar cambios' : 'Editar perfil',
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              _userData['nombre']?.isNotEmpty == true
                  ? _userData['nombre'][0].toUpperCase()
                  : '?',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          SizedBox(height: 16),
          Text(
            '${_userData['nombre'] ?? ''} ${_userData['apellido'] ?? ''}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            _userData['email'] ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.email, 'Correo electrónico', _userData['email'] ?? 'N/A'),
            _buildInfoRow(Icons.person, 'Nombre', _userData['nombre'] ?? 'N/A'),
            _buildInfoRow(Icons.person, 'Apellido', _userData['apellido'] ?? 'N/A'),
            _buildInfoRow(Icons.phone, 'Teléfono', _userData['telefono'] ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              _buildTextField('Correo electrónico', Icons.email, 'email'),
              SizedBox(height: 16),
              _buildTextField('Nombre', Icons.person, 'nombre'),
              SizedBox(height: 16),
              _buildTextField('Apellido', Icons.person, 'apellido'),
              SizedBox(height: 16),
              _buildTextField('Teléfono', Icons.phone, 'telefono'),
              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _updateUserData,
                icon: Icon(Icons.save),
                label: Text('Guardar cambios'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, String field) {
    return TextFormField(
      initialValue: _userData[field],
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) => _userData[field] = value,
    );
  }
}