import 'dart:async'; // Para usar Timer
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class Event {
  final String nameEvent;
  final String description;
  final double cost;
  final String address;

  Event({required this.nameEvent, required this.description, required this.cost, required this.address});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      nameEvent: json['nameEvent'],
      description: json['description'],
      cost: json['cost']?.toDouble() ?? 0.0,
      address: json['address'],
    );
  }
}

class MuseumViewModel extends ChangeNotifier {
  List<Event> events = [];
  bool isLoading = false;

  Future<void> fetchEvents() async {
    final startDate = _getStartOfWeek(DateTime.now());
    final endDate = _getEndOfWeek(DateTime.now());

    isLoading = true;
    notifyListeners();

    await _attemptFetch(startDate, endDate);
    
    isLoading = false;
    notifyListeners();
  }

  Future<void> _attemptFetch(String startDate, String endDate) async {
    int retries = 0;
    while (retries < 5) {
      final url = Uri.parse('http://177.240.8.254:83/GetEvent/$startDate/$endDate');
      print(url);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        events = jsonData.map((json) => Event.fromJson(json)).toList();
        return; // Salir si la carga fue exitosa
      } else {
        retries++;
        print("Intento $retries fallido. Reintentando en 5 segundos...");
        await Future.delayed(Duration(seconds: 5)); // Esperar 5 segundos antes de reintentar
      }
    }
    // Si llegamos aquí, no se pudieron cargar los eventos
    events = [];
  }

  String _getStartOfWeek(DateTime date) {
    final daysToSubtract = date.weekday - DateTime.monday;
    final startOfWeek = date.subtract(Duration(days: daysToSubtract));
    return DateFormat('yyyy-MM-dd').format(startOfWeek);
  }

  String _getEndOfWeek(DateTime date) {
    final daysToAdd = DateTime.saturday - date.weekday;
    final endOfWeek = date.add(Duration(days: daysToAdd));
    return DateFormat('yyyy-MM-dd').format(endOfWeek);
  }
}
