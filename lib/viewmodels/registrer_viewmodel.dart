import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RegistrerViewmodel with ChangeNotifier{
  String _name = '';
  String _fLastName = '';
  String _sLastName = '';
  String _email = '';
  String _password = '';

  //Setter

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

  //Metodo para realizar el POST 
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
      if (kDebugMode) {
        print("Error al llamar a la API: $e");
      }
      return false;
    }
  }
}