import 'package:flutter/material.dart';
import 'package:biblioteca_app/obj/classes.dart';
import 'package:biblioteca_app/search.dart';
import 'package:biblioteca_app/widgets/input.dart';
import 'package:biblioteca_app/widgets/view.dart';

class Menu extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> novaPesquisa() async {
      List resultados = [];
      try {
        List<dynamic> bibliotecas =
            await Pesquisa.getLibrary(textController.text);
        List<dynamic> books = await Pesquisa.getBooks(textController.text);
        for (var biblioteca in bibliotecas) {
          resultados.add(biblioteca.cast());
        }
        resultados.addAll(books);
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return Search(resultados: resultados, pesquisa: textController.text);
        }));
      } catch (e) {
        debugPrint(e.toString());
      }
    }

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
