import 'package:biblioteca_app/widgets/input.dart';
import 'package:biblioteca_app/widgets/view.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final String pesquisa;
  const Search({super.key, required this.pesquisa});

  @override
  State<StatefulWidget> createState() {
    return _ListaResultados();
  }
}

class _ListaResultados extends State<Search> {
  late String pesquisa;

  @override
  void initState() {
    super.initState();
    pesquisa = widget.pesquisa;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoCompleteInput(),
      ),
      body: ListView(
        children: const [ItemList(livro: true), ItemList(livro: false)],
      ),
    );
  }
}
