import 'package:biblioteca_app/obj/search.dart';
import 'package:biblioteca_app/search_page.dart';
import 'package:biblioteca_app/obj/classes.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  final Book livro;
  const BookPage({super.key, required this.livro});

  @override
  State<StatefulWidget> createState() {
    return _Estado();
  }
}

class _Estado extends State<BookPage> {
  late Book livro;
  bool isActived = false;

  @override
  void initState() {
    livro = widget.livro;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 110, 160, 213),
      appBar: AppBar(
        title: Text(livro.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 250,
                  height: 200,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Image.network(livro.imageUrl)]),
                ),
              ),
              Text(
                livro.authors,
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 173, 165, 165)),
              ),
              Text(
                livro.synopsis,
                style: const TextStyle(fontSize: 20),
                maxLines: isActived ? 100 : 3,
                overflow: TextOverflow.ellipsis,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isActived = !isActived;
                    });
                  },
                  icon: isActived
                      ? const Icon(Icons.arrow_drop_up_rounded)
                      : const Icon(Icons.arrow_drop_down_rounded)),
              Center(child: botao(livro.title, context)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget botao(String bookName, context) {
  return FutureBuilder<Widget>(
    future: createBotao(bookName, context),
    builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Retorna um widget de carregamento enquanto o futuro está sendo resolvido
        return const CircularProgressIndicator();
      } else {
        // Retorna o widget resolvido do futuro
        return snapshot.data ??
            Container(); // Se snapshot.data for nulo, retorna um Container()
      }
    },
  );
}

Future<Widget> createBotao(String bookName, context) async {
  var resposta = await Search.getLocations(bookName);

  if (resposta.isEmpty) {
    return Container();
  }

  return ElevatedButton(
    onPressed: () {
      List resultados = [];
      for (var i in resposta) {
        resultados.add(i.asBook());
      }
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return SearchPage(
          pesquisa: bookName,
          tipo: Types.ondeEncontrar,
        );
      }));
    },
    child: const Text('Onde encontrar'),
  );
}
