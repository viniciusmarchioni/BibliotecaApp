import 'package:biblioteca_app/obj/classes.dart';
import 'package:biblioteca_app/widgets/input.dart';
import 'package:biblioteca_app/widgets/view.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final List resultados;
  final TextEditingController textController;
  const Search(
      {super.key, required this.resultados, required this.textController});

  @override
  State<StatefulWidget> createState() {
    return _ListaResultados();
  }
}

class _ListaResultados extends State<Search> {
  late List resultados;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    resultados = widget.resultados;
    textController = widget.textController;
  }
  /*
  Future<List<Livro>> getBooks() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:5000/search/${textController.text}'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((obj) => Livro.fromJson(obj)).toList();
    } else {
      throw Exception('Falha ao carregar objetos');
    }
  }*/

  Future<List<Livro>> getBooks() async {
    List<Livro> list = [];
    final baseUrl = Uri.parse('https://www.googleapis.com/books/v1/volumes');

    final params = {'q': textController.text};

    final response = await http.get(baseUrl.replace(queryParameters: params));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for (var item in data['items']) {
        var volumeInfo = item['volumeInfo'] ?? {};
        var coverUrl = volumeInfo.containsKey('imageLinks')
            ? volumeInfo['imageLinks']['thumbnail']
            : null;
        var title = volumeInfo['title'] ?? 'N/A';
        var authors =
            volumeInfo.containsKey('authors') ? volumeInfo['authors'] : ['N/A'];
        var sinopse = volumeInfo['description'] ?? 'N/A';
        list.add(Livro(
            titulo: title,
            autores: authors.toString(),
            sinopse: sinopse,
            tema: 'N/A',
            imageUrl: coverUrl));
      }
      return list;
    } else {
      print('Erro ao fazer a solicitação: ${response.statusCode}');
      list = [];
      return list;
    }
  }

  void novaPesquisa() async {
    resultados.clear();
    try {
      resultados = await getBooks();
    } catch (e) {
      resultados = [];
    }

    setState(() {
      resultados = resultados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: InputSearch(
        onSubmitted: novaPesquisa,
        searchInput: textController,
      )),
      body: ListView(
        children: [
          for (Livro i in resultados)
            ItemList(
              book: i,
            )
        ],
      ),
    );
  }
}
