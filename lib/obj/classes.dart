import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Suggestion {
  final String name;

  Suggestion({required this.name});

  factory Suggestion.fromJson(String json) {
    return Suggestion(name: json);
  }
}

class Book {
  final bool isBook;
  final String imageUrl;
  final String title;
  final int id;
  final String authors;
  final String synopsis;
  final String theme;

  Book({
    required this.isBook,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.authors,
    required this.synopsis,
    required this.theme,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['titulo'],
      authors: json['autores'],
      synopsis: json['sinopse'],
      theme: json['tema'],
      imageUrl: json['image'],
      isBook: true,
      id: json['id'],
    );
  }
}

class Library {
  final String name;
  final String address;

  Library({required this.name, required this.address});

  Book asBook() {
    return Book(
      imageUrl:
          'https://pbs.twimg.com/media/GGxpGBKXAAAkdwf?format=jpg&name=small',
      title: name,
      authors: address,
      synopsis: 'Library',
      theme: 'Library',
      isBook: false,
      id: 0,
    );
  }

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      name: json['nome'],
      address: json['endereco'],
    );
  }
}

class Search {
  static const String _baseUrl = 'http://10.0.2.2:5000';

  static Future<List<dynamic>> _fetchData(String endpoint) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/$endpoint'))
          .timeout(const Duration(seconds: 5));
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
    final jsonResponse = await _fetchData('search/$string');
    return jsonResponse.map((obj) => Book.fromJson(obj)).toList();
  }

  static Future<List<dynamic>> getLibraries(String string) async {
    try {
      final jsonResponse = await _fetchData('bibliotecas/$string');
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
      final jsonResponse = await _fetchData('search/bibliotecas/$string');
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

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}

class Account {
  String? nome;
  String? email;

  Account(this.nome, this.email);

  static Future<void> saveAccount(Account conta) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (conta.nome != null) {
      await prefs.setString('name', conta.nome!);
    } else {
      throw ('Invalid name');
    }

    if (conta.email != null) {
      await prefs.setString('email', conta.email!);
    } else {
      throw ('Invalid email');
    }
  }

  static Future<bool> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final String? name = prefs.getString('name');
      final String? email = prefs.getString('email');
      return (name != null &&
          email != null &&
          name.isNotEmpty &&
          email.isNotEmpty);
    } catch (e) {
      return false;
    }
  }

  static Future<Account> getAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString('name');
    final String? email = prefs.getString('email');
    return Account(name, email);
  }

  static Future<void> setFavorite(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      List<String>? lista = prefs.getStringList('favoritos');
      if (lista == null) {
        await prefs.setStringList('favoritos', <String>[id]);
      } else {
        await prefs.setStringList('favoritos', <String>[id, ...lista]);
      }
    } catch (e) {
      await prefs.setStringList('favoritos', <String>[id]);
    }
  }

  static Future<List<String>?> getFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favoritos');
  }

  static Future<void> deleteFavorite(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      List<String>? lista = prefs.getStringList('favoritos');
      if (lista != null && lista.contains(id)) {
        lista.remove(id);
        await prefs.setStringList('favoritos', lista);
      }
    } catch (e) {
      debugPrint('Error deleting favorite: $e');
    }
  }

  static Future<void> deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
  }
}

class FailedToLoadException implements Exception {
  final String message;

  FailedToLoadException(this.message);
}
