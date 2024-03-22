import 'package:flutter/material.dart';
import 'package:biblioteca_app/obj/classes.dart';
import 'package:biblioteca_app/search_page.dart';
import 'package:biblioteca_app/widgets/input.dart';
import 'package:biblioteca_app/widgets/view.dart';

class Menu extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  //final user;
  Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> novaPesquisa() async {
      List resultados = [];
      try {
        List<dynamic> bibliotecas =
            await Search.getLibraries(textController.text);
        List<dynamic> books = await Search.getBooks(textController.text);
        for (var biblioteca in bibliotecas) {
          resultados.add(biblioteca.asBook());
        }
        resultados.addAll(books);
        String valor = textController.text;
        textController.text = '';

        if (context.mounted) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return SearchPage(resultados: resultados, pesquisa: valor);
          }));
        }
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
