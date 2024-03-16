import 'package:biblioteca_app/obj/classes.dart';
import 'package:biblioteca_app/widgets/input.dart';
import 'package:biblioteca_app/widgets/view.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final String pesquisa;
  final List resultados;
  const Search({super.key, required this.pesquisa, required this.resultados});

  @override
  State<StatefulWidget> createState() {
    return _ListaResultados();
  }
}

class _ListaResultados extends State<Search> {
  late String pesquisa;
  late List resultados;

  @override
  void initState() {
    super.initState();
    pesquisa = widget.pesquisa;
    resultados = widget.resultados;
  }

  @override
  Widget build(BuildContext context) {
    print(resultados);
    return Scaffold(
      appBar: AppBar(
        title: AutoCompleteInput(),
      ),
      body: ListView(
        children: [
          for (Livro i in resultados)
            ItemList(
              isLivro: true,
              titulo: i.titulo,
              autores: i.autores,
              book: i,
            )
        ],
      ),
    );
  }
}
