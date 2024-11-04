import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterViewModel with ChangeNotifier {
  String _name = '';
  String _fLastName = '';
  String _sLastName = '';
  String _email = '';
  String _password = '';
  // Setters
  set name(String name) {
    _name = name;
    notifyListeners();
  }

  set fLastName(String fLastName) {
    _fLastName = fLastName;
    notifyListeners();
  }

  set sLastName(String sLastName) {
    _sLastName = sLastName;
    notifyListeners();
  }

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  set password(String password) {
    _password = password;
    notifyListeners();
  }



  // Método para enviar datos a la API
  Future<bool> registerUser() async {
    final url = Uri.parse(
      'http://177.240.8.254:83/InsertUser/$_name/$_fLastName/$_sLastName/$_email/$_password/usuario',
    );

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        // Asumimos que la API devuelve `true` si el registro es exitoso
        return jsonDecode(response.body) == true;
      }
      return false;
    } catch (e) {
      print("Error al llamar a la API: $e");
      return false;
    }
  }
}
