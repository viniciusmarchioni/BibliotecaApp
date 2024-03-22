import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

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
  final String authors;
  final String synopsis;
  final String theme;

  Book({
    required this.isBook,
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
  static Future<List<dynamic>> getBooks(String string) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/search/$string'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List<dynamic>;
      return jsonResponse.map((obj) => Book.fromJson(obj)).toList();
    } else {
      throw Exception('Failed to load objects');
    }
  }

  static Future<List<dynamic>> getLibraries(String string) async {
    try {
      final response = await http
          .get(
            Uri.parse('http://10.0.2.2:5000/bibliotecas/$string'),
          )
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;
        return jsonResponse.map((obj) => Library.fromJson(obj)).toList();
      } else {
        throw Exception('Failed to load objects');
      }
    } on TimeoutException {
      debugPrint('----------------TIMEOUT------------');
      return [];
    } on HttpException {
      debugPrint('----------------Erro ao conectar a api------------');
      return [];
    }
  }

  static Future<List<dynamic>> getLocations(String string) async {
    try {
      final response = await http
          .get(
            Uri.parse('http://10.0.2.2:5000/search/bibliotecas/$string'),
          )
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;
        return jsonResponse.map((obj) => Library.fromJson(obj)).toList();
      } else {
        throw Exception('Failed to load objects');
      }
    } on TimeoutException {
      debugPrint('----------------TIMEOUT------------');
      return [];
    } on HttpException {
      debugPrint('----------------Erro ao conectar a api------------');
      return [];
    }
  }
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}
