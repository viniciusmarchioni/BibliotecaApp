import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:biblioteca_app/obj/classes.dart';
import 'package:biblioteca_app/widgets/input.dart';
import 'package:biblioteca_app/widgets/view.dart';

class Search extends StatefulWidget {
  final List<dynamic> resultados;
  final String pesquisa;

  const Search({
    Key? key,
    required this.resultados,
    required this.pesquisa,
  }) : super(key: key);

  @override
  createState() => _ListaResultadosState();
}

class _ListaResultadosState extends State<Search> {
  late List<dynamic> resultados;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    resultados = widget.resultados;
    textController = TextEditingController();
  }

  Future<List<dynamic>> getBooks() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/search/${textController.text}'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List<dynamic>;
      return jsonResponse.map((obj) => Livro.fromJson(obj)).toList();
    } else {
      throw Exception('Failed to load objects');
    }
  }

  Future<List<dynamic>> getLibrary() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/bibliotecas/${textController.text}'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List<dynamic>;
      return jsonResponse.map((obj) => Biblioteca.fromJson(obj)).toList();
    } else {
      throw Exception('Failed to load objects');
    }
  }

  Future<void> novaPesquisa() async {
    try {
      final List<dynamic> bibliotecas = await getLibrary();
      final List<dynamic> books = await getBooks();
      resultados.clear();
      resultados.addAll(bibliotecas);
      resultados.addAll(books);
      setState(() {});
    } catch (e) {
      setState(() {
        resultados.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InputSearch(
          searchInput: textController,
          onSubmitted: novaPesquisa,
        ),
      ),
      body: ListView(
        children: [
          for (var item in resultados)
            if (item is Livro)
              ItemList(book: item)
            else if (item is Biblioteca)
              ItemList(book: item.cast())
        ],
      ),
    );
  }
}
