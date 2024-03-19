import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:biblioteca_app/obj/classes.dart';
import 'package:biblioteca_app/search.dart';
import 'package:biblioteca_app/widgets/input.dart';
import 'package:biblioteca_app/widgets/view.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late final TextEditingController textController;
  late List<dynamic> resultados;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    resultados = [];
  }

  Future<List<dynamic>> getBooks() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:5000/search/${textController.text}'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((obj) => Livro.fromJson(obj)).toList();
    } else {
      throw Exception('Failed to load objects');
    }
  }

  Future<List<dynamic>> getLibrary() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/bibliotecas/${textController.text}'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((obj) => Biblioteca.fromJson(obj)).toList();
    } else {
      throw Exception('Failed to load objects');
    }
  }

  Future<void> novaPesquisa() async {
    resultados = [];
    try {
      List<dynamic> bibliotecas = await getLibrary();
      List<dynamic> books = await getBooks();
      for (var biblioteca in bibliotecas) {
        resultados.add(biblioteca.cast());
      }
      resultados.addAll(books);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return Search(resultados: resultados, pesquisa: textController.text);
      }));
    } catch (e) {
      setState(() {
        resultados = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: InputSearch(
            onSubmitted: novaPesquisa,
            searchInput: textController,
          ),
        ),
      ),
      body: const Grid(),
    );
  }
}
