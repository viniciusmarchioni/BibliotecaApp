//import 'dart:convert';
//import 'package:biblioteca_app/obj/classes.dart';
import 'package:biblioteca_app/widgets/input.dart';
import 'package:biblioteca_app/widgets/view.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

class Menu extends StatefulWidget {
  final String name;

  const Menu({super.key, required this.name});

  @override
  State<StatefulWidget> createState() {
    return _MenuState();
  }
}

class _MenuState extends State<Menu> {
  /*
  Future fetch() async {
    var url = 'http://10.0.2.2:5000/livros/';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<String> livroListJson =
          List<String>.from(json.decode(response.body)['list']);
      List<Sujestoes> livroList =
          livroListJson.map((json) => Sujestoes.fromJson(json)).toList();
      setState(() {
        for (var element in livroList) {
          livros.add(element.nome);
        }
      });
      print(livros);
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoCompleteInput(),
      ),
      body: const Grid(),
    );
  }
}
