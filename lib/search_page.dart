import 'package:biblioteca_app/obj/search.dart';
import 'package:biblioteca_app/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_app/obj/classes.dart';
import 'package:biblioteca_app/widgets/input.dart';

class SearchPage extends StatefulWidget {
  final Types tipo;
  final String pesquisa;

  const SearchPage({
    Key? key,
    required this.pesquisa,
    required this.tipo,
  }) : super(key: key);

  @override
  createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> resultados = [];
  late Types tipo;
  late TextEditingController textController = TextEditingController();
  late String pesquisa;

  @override
  void initState() {
    tipo = widget.tipo;
    pesquisa = widget.pesquisa;
    super.initState();
  }

  Future<void> novaPesquisa() async {
    resultados = [];
    try {
      final List<dynamic> bibliotecas =
          await Search.getLibraries(textController.text);
      final List<dynamic> books = await Search.getBooks(textController.text);

      for (Library i in bibliotecas) {
        resultados.add(i);
      }
      resultados.addAll(books);
    } catch (e) {
      resultados.clear();
    }
  }

  Future<void> pesquisaMenu() async {
    resultados.clear();
    try {
      final List<dynamic> bibliotecas = await Search.getLibraries(pesquisa);
      final List<dynamic> books = await Search.getBooks(pesquisa);

      for (Library i in bibliotecas) {
        resultados.add(i);
      }
      resultados.addAll(books);
    } catch (e) {
      resultados.clear();
    }
  }

  Future<void> pesquisaFav() async {
    try {
      resultados = await Search.postAndGetFavorites();
    } catch (e) {
      resultados.clear();
    }
  }

  Future<void> pesquisaLivro() async {
    try {
      resultados = await Search.getBooks('Harry');
    } catch (e) {
      resultados.clear();
    }
  }

  Future<void> pesquisaBiblioteca() async {
    try {
      resultados = await Search.getLibraries('e');
    } catch (e) {
      resultados.clear();
    }
  }

  Future<void> pesquisaLocais() async {
    try {
      resultados = await Search.getLocations(pesquisa);
    } catch (e) {
      resultados.clear();
    }
  }

  Future<void> _defineType(Types tipo) {
    if (tipo == Types.biblioteca) {
      return pesquisaBiblioteca();
    } else if (tipo == Types.livros) {
      return pesquisaLivro();
    } else if (tipo == Types.favoritos) {
      return pesquisaFav();
    } else if (tipo == Types.pesquisaMenu) {
      return pesquisaMenu();
    } else if (tipo == Types.ondeEncontrar) {
      return pesquisaLocais();
    }
    return novaPesquisa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InputSearch(
          searchInput: textController,
          onSubmitted: () {
            setState(() {
              tipo = Types.pesquisa;
            });
          },
        ),
      ),
      body: FutureBuilder(
        future: _defineType(tipo),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildResultsWidget(resultados);
          }
        },
      ),
    );
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
            LibraryList(library: item)
      ],
    );
  }
}
