import 'dart:math';
import 'package:biblioteca_app/search.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:biblioteca_app/obj/classes.dart';
import 'package:http/http.dart' as http;

const List<String> _optionlivros = [
  "Dom Quixote",
  "Cem Anos de Solidão",
  "1984",
  "O Pequeno Príncipe",
  "O Senhor dos Anéis",
  "A Bíblia",
  "Harry Potter e a Pedra Filosofal",
  "O Alquimista",
  "Orgulho e Preconceito",
  "Matar um Rouxinol",
  "A Revolução dos Bichos",
  "A Divina Comédia",
  "Crime e Castigo",
  "Ensaio sobre a Cegueira",
  "O Grande Gatsby",
  "Ulisses",
  "O Sol é para Todos",
  "Cem Anos de Solidão",
  "Lolita",
  "O Apanhador no Campo de Centeio",
  "Os Miseráveis",
  "Moby Dick",
  "1984",
  "O Leão, a Feiticeira e o Guarda-Roupa",
  "O Código Da Vinci",
  "A Menina que Roubava Livros",
  "Harry Potter e as Relíquias da Morte",
  "O Hobbit",
  "Anna Karenina",
  "O Nome da Rosa",
  "O Senhor das Moscas",
  "O Silmarillion",
  "O Iluminado",
  "O Caçador de Pipas",
  "O Médico e o Monstro",
  "O Retrato de Dorian Gray",
  "O Morro dos Ventos Uivantes",
  "As Crônicas de Nárnia",
  "O Processo",
  "O Velho e o Mar",
  "O Poderoso Chefão",
  "A Metamorfose",
  "Memórias Póstumas de Brás Cubas",
  "O Homem Invisível",
  "O Lobo da Estepe",
  "O Exorcista",
  "O Perfume",
  "O Estrangeiro",
  "O Cão dos Baskervilles",
  "O Coração das Trevas",
];

class AutoCompleteInput extends StatelessWidget {
  final searchInput = TextEditingController();
  AutoCompleteInput({super.key});

  Future<List<Livro>> getBooks() async {
    List<Livro> list = [];
    final baseUrl = Uri.parse('https://www.googleapis.com/books/v1/volumes');

    final params = {'q': searchInput.text};

    final response = await http.get(baseUrl.replace(queryParameters: params));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for (var item in data['items']) {
        var volumeInfo = item['volumeInfo'] ?? {};
        var coverUrl = volumeInfo.containsKey('imageLinks')
            ? volumeInfo['imageLinks']['thumbnail']
            : 'N/A';
        var title = volumeInfo['title'] ?? 'N/A';
        var authors =
            volumeInfo.containsKey('authors') ? volumeInfo['authors'] : ['N/A'];
        var sinopse = volumeInfo['description'] ?? 'N/A';
        list.add(Livro(
            titulo: title,
            autores: authors.toString(),
            sinopse: sinopse,
            tema: 'N/A',
            imageUrl: coverUrl));
      }
      return list;
    } else {
      print('Erro ao fazer a solicitação: ${response.statusCode}');
      list = [];
      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> changePage(String value) async {
      var livros = await getBooks();
      if (searchInput.text == '') {
        return;
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return Search(
                resultados: livros,
                textController: searchInput,
              );
            },
          ),
        );
      }
    }

    return Autocomplete<String>(
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return Center(
          child: SizedBox(
            width: 275,
            height: 50,
            child: TextField(
              onSubmitted: changePage,
              textInputAction: TextInputAction.search,
              controller: searchInput,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: '${_optionlivros[Random().nextInt(49)]}...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    searchInput.clear();
                  },
                  child: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _optionlivros.where((String option) {
          return option.contains(textEditingValue.text);
        });
      },
    );
  }
}

class InputSearch extends StatelessWidget {
  final searchInput;
  final Function() onSubmitted;

  const InputSearch({
    super.key,
    required this.searchInput,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 275,
      height: 50,
      child: TextField(
        onSubmitted: (value) {
          onSubmitted();
        },
        textInputAction: TextInputAction.search,
        controller: searchInput,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: '${_optionlivros[Random().nextInt(49)]}...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              searchInput.clear();
            },
            child: const Icon(Icons.clear),
          ),
        ),
      ),
    );
  }
}
