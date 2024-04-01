import 'package:biblioteca_app/library_page.dart';
import 'package:biblioteca_app/main.dart';
import 'package:biblioteca_app/obj/account.dart';
import 'package:biblioteca_app/search_page.dart';
import 'package:biblioteca_app/book_page.dart';
import 'package:biblioteca_app/obj/classes.dart';
import 'package:biblioteca_app/widgets/icon.dart';
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
        book.id != 0
            ? Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return BookPage(
                      livro: Book(
                          title: book.title,
                          authors: book.authors,
                          synopsis: book.synopsis,
                          theme: book.theme,
                          imageUrl: book.imageUrl,
                          isBook: book.isBook,
                          id: book.id),
                    );
                  },
                ),
              )
            : Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return LibraryPage(
                      livro: Book(
                          title: book.title,
                          authors: book.authors,
                          synopsis: book.synopsis,
                          theme: book.theme,
                          imageUrl: book.imageUrl,
                          isBook: book.isBook,
                          id: book.id),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getLimitedAuthors(book.authors),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 196, 188, 188)),
                      ),
                      Favorite(bookId: book.id)
                    ],
                  )
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
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const SearchPage(
        pesquisa: 'e',
        tipo: Types.biblioteca,
      );
    }));
  } else if (index == 1) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const SearchPage(
        pesquisa: 'Harry',
        tipo: Types.livros,
      );
    }));
  } else if (index == 2) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const SearchPage(
        pesquisa: '',
        tipo: Types.favoritos,
      );
    }));
  } else if (index == 4) {
    Account.deleteAccount();
    if (context.mounted) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return const MyApp();
      }));
    }
  }
  return [];
}

String _getTitle(index) {
  switch (index) {
    case 0:
      return 'Bibliotecas';
    case 1:
      return 'Livros';
    case 2:
      return 'Favoritos';
    case 3:
      return 'Configurações';
    case 4:
      return 'Sair';
    default:
      return 'Placeholder';
  }
}

String _getImage(index) {
  switch (index) {
    case 0:
      return 'assets/library.jpg';
    case 1:
      return 'assets/book.jpg';
    case 2:
      return 'assets/fav.jpg';
    case 3:
      return 'assets/configuracoes.jpg';
    case 4:
      return 'assets/sair.png';
    default:
      return 'assets/yuri.jpg';
  }
}

String _getLimitedAuthors(String authors) {
  // Limitar o autor a 20 caracteres
  if (authors.length > 20) {
    return '${authors.substring(0, 20)}...';
  }
  return authors;
}
