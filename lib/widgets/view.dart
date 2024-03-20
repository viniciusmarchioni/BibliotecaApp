import 'package:biblioteca_app/SearchPage.dart';
import 'package:biblioteca_app/modular_page.dart';
import 'package:biblioteca_app/obj/classes.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 5,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            splashColor: Colors.black26,
            onTap: () {
              _onTapFunc(index, context);
            },
            child: Ink.image(
              image: AssetImage(_getImage(index)),
              child: Center(
                child: Text(
                  _getTitle(index),
                  style: const TextStyle(
                      color: Colors.white, backgroundColor: Colors.black),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ItemList extends StatelessWidget {
  final Book book;
  const ItemList({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return ModularPage(
                livro: Book(
                    title: book.title,
                    authors: book.authors,
                    synopsis: book.synopsis,
                    theme: book.theme,
                    imageUrl: book.imageUrl,
                    isBook: book.isBook),
              );
            },
          ),
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
        color: book.isBook
            ? const Color.fromARGB(255, 110, 160, 213)
            : const Color.fromARGB(255, 46, 110, 58),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: 80,
              child: book.imageUrl == ''
                  ? Image.network(
                      'https://pbs.twimg.com/media/GGxpGBKXAAAkdwf?format=jpg&name=small')
                  : Image.network(book.imageUrl),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: Text(
                      book.title,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    book.authors,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 196, 188, 188)),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List> _onTapFunc(int index, context) async {
  if (index == 0) {
    List<dynamic> resultados = await Search.getLibraries('e');
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return SearchPage(resultados: resultados, pesquisa: 'e');
    }));
  } else if (index == 1) {
    List<dynamic> resultados = await Search.getBooks('Harry');
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return SearchPage(resultados: resultados, pesquisa: 'Harry');
    }));
  }
  return [];
}

String _getTitle(index) {
  switch (index) {
    case 0:
      return 'Bibliotecas';
    case 1:
      return 'Livros';
    default:
      return 'Yuri Alberto';
  }
}

String _getImage(index) {
  switch (index) {
    case 0:
      return 'assets/library.jpg';
    case 1:
      return 'assets/book.jpg';
    default:
      return 'assets/yuri.jpg';
  }
}
