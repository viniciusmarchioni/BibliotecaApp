import 'package:biblioteca_app/obj/classes.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_app/search_page.dart';
import 'package:biblioteca_app/widgets/input.dart';
import 'package:biblioteca_app/widgets/view.dart';

class Menu extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> novaPesquisa() async {
      String valor = textController.text;
      if (context.mounted) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return SearchPage(
            pesquisa: valor,
            tipo: Types.pesquisaMenu,
          );
        }));
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
