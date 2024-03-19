import 'dart:convert';
import 'package:http/http.dart' as http;

class Sujestoes {
  String nome;

  Sujestoes({required this.nome});

  factory Sujestoes.fromJson(String json) {
    return Sujestoes(nome: json);
  }
}

class Livro {
  bool isLivro = true;
  String imageUrl;
  String titulo;
  String autores;
  String sinopse;
  String tema;

  Livro(
      {required this.isLivro,
      required this.imageUrl,
      required this.titulo,
      required this.autores,
      required this.sinopse,
      required this.tema});

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      titulo: json['titulo'],
      autores: json['autores'],
      sinopse: json['sinopse'],
      tema: json['tema'],
      imageUrl: json['image'],
      isLivro: true,
    );
  }
}

class Biblioteca {
  String nome;
  String endereco;

  Biblioteca({required this.nome, required this.endereco});

  Livro cast() {
    return Livro(
        imageUrl:
            'https://pbs.twimg.com/media/GGxpGBKXAAAkdwf?format=jpg&name=small',
        titulo: nome,
        autores: endereco,
        sinopse: 'Biblioteca',
        tema: 'Biblioteca',
        isLivro: false);
  }

  factory Biblioteca.fromJson(Map<String, dynamic> json) {
    return Biblioteca(
      nome: json['nome'],
      endereco: json['endereco'],
    );
  }
}

class Pesquisa {
  static Future<List<dynamic>> getBooks(String string) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/search/$string'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List<dynamic>;
      return jsonResponse.map((obj) => Livro.fromJson(obj)).toList();
    } else {
      throw Exception('Failed to load objects');
    }
  }

  static Future<List<dynamic>> getLibrary(String string) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/bibliotecas/$string'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List<dynamic>;
      return jsonResponse.map((obj) => Biblioteca.fromJson(obj)).toList();
    } else {
      throw Exception('Failed to load objects');
    }
  }
}
