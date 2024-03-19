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

  Future<List<Livro>> getBooks() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:5000/search/${textController.text}'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((obj) => Livro.fromJson(obj)).toList();
    } else {
      throw Exception('Falha ao carregar objetos');
    }
  }

  Future<List<Biblioteca>> getlibrary() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/bibliotecas/${textController.text}'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((obj) => Biblioteca.fromJson(obj)).toList();
    } else {
      throw Exception('Falha ao carregar objetos');
    }
  }

  void novaPesquisa() async {
    resultados.clear();

    try {
      List<Biblioteca> bibliotecas = await getlibrary();
      resultados = await getBooks();
      for (Biblioteca i in bibliotecas) {
        resultados.add(i.cast());
      }
    } catch (e) {
      print(e);
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
            if (i.isLivro)
              ItemList(
                book: i,
              )
            else
              ItemList(
                book: i,
              )
        ],
      ),
    );
  }
}
