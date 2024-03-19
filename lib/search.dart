import 'package:flutter/material.dart';
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
  late TextEditingController textController = TextEditingController();

  @override
  void initState() {
    resultados = widget.resultados;
    super.initState();
  }

  Future<void> novaPesquisa() async {
    resultados.clear();
    try {
      final List<dynamic> bibliotecas =
          await Pesquisa.getLibrary(textController.text);
      final List<dynamic> books = await Pesquisa.getBooks(textController.text);

      resultados.addAll(bibliotecas);
      resultados.addAll(books);
      setState(() {
        resultados;
      });
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
