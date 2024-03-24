import 'package:flutter/material.dart';
import 'package:biblioteca_app/obj/classes.dart';
import 'package:biblioteca_app/widgets/input.dart';
import 'package:biblioteca_app/widgets/view.dart';

class SearchPage extends StatefulWidget {
  final List<dynamic> resultados;
  final String pesquisa;

  const SearchPage({
    Key? key,
    required this.resultados,
    required this.pesquisa,
  }) : super(key: key);

  @override
  createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
          await Search.getLibraries(textController.text);
      final List<dynamic> books = await Search.getBooks(textController.text);

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
        body: _buildResultsWidget(resultados));
  }
}

Widget _buildResultsWidget(List<dynamic> resultados) {
  if (resultados.isEmpty) {
    return const Center(
      child: Text('Sua pesquisa não retornou resultados :('),
    );
  } else {
    return ListView(
      children: [
        for (var item in resultados)
          if (item is Book)
            ItemList(book: item)
          else if (item is Library)
            ItemList(book: item.asBook())
      ],
    );
  }
}
