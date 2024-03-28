import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:biblioteca_app/obj/account.dart';
import 'package:biblioteca_app/obj/classes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search {
  static const String _baseUrl = 'http://10.0.2.2:5000';

  static Future<List<dynamic>> _fetchData(String endpoint) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/$endpoint'))
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        return json.decode(response.body) as List<dynamic>;
      } else {
        throw Exception('Failed to load objects');
      }
    } on TimeoutException {
      debugPrint('----------------TIMEOUT------------');
      return [];
    } on HttpException {
      debugPrint('----------------Failed to connect to API------------');
      return [];
    }
  }

  static Future<List<dynamic>> getBooks(String string) async {
    final jsonResponse = await _fetchData('search/${_correcao(string)}');
    return jsonResponse.map((obj) => Book.fromJson(obj)).toList();
  }

  static Future<List<dynamic>> getLibraries(String string) async {
    try {
      final jsonResponse = await _fetchData('bibliotecas/${_correcao(string)}');
      return jsonResponse.map((obj) => Library.fromJson(obj)).toList();
    } on TimeoutException {
      debugPrint('----------------TIMEOUT------------');
      return [];
    } on HttpException {
      debugPrint('----------------Failed to connect to API------------');
      return [];
    }
  }

  static Future<List<dynamic>> postAndGetFavorites() async {
    try {
      final lista = await Account.getFavorite();
      final response = await http.post(
        Uri.parse('$_baseUrl/favorite/'),
        body: jsonEncode({"id": lista}),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      ).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;
        return jsonResponse.map((obj) => Book.fromJson(obj)).toList();
      } else {
        throw Exception('Failed to load objects');
      }
    } on TimeoutException {
      debugPrint('----------------TIMEOUT------------');
      return [];
    } on HttpException {
      debugPrint('----------------Failed to connect to API------------');
      return [];
    }
  }

  static Future<List<dynamic>> getLocations(String string) async {
    try {
      final jsonResponse =
          await _fetchData('search/bibliotecas/${_correcao(string)}');
      return jsonResponse.map((obj) => Library.fromJson(obj)).toList();
    } on TimeoutException {
      debugPrint('----------------TIMEOUT------------');
      return [];
    } on HttpException {
      debugPrint('----------------Failed to connect to API------------');
      return [];
    }
  }
}

String _correcao(String string) {
  string = string.replaceAll('-', '');
  return string.replaceAll('/', '');
}
