import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginViewModel with ChangeNotifier {
  String _email = '';
  String _password = '';

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  Future<bool> loginUser() async {
    final url = Uri.parse('http://177.240.8.254:83/GetValidUser/$_email/$_password');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Validar respuesta de la API
        return jsonDecode(response.body) == true;
      }
      return false;
    } catch (e) {
      print("Error al llamar a la API: $e");
      return false;
    }
  }
}
