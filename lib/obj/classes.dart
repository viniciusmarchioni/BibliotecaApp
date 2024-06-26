import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

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
  final String image;
  final double lat;
  final double long;
  final int? disp;

  Library(
      {this.disp,
      required this.lat,
      required this.long,
      required this.image,
      required this.name,
      required this.address});

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      disp: json['disponibilidade'],
      long: json['longitude'],
      lat: json['latitude'],
      image: json['image'],
      name: json['nome'],
      address: json['endereco'],
    );
  }
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}

class FailedToLoadException implements Exception {
  final String message;

  FailedToLoadException(this.message);
}

enum Types {
  biblioteca,
  livros,
  favoritos,
  pesquisa,
  pesquisaMenu,
  ondeEncontrar
}
