import 'package:biblioteca_app/book_page.dart';
import 'package:biblioteca_app/library_page.dart';
import 'package:biblioteca_app/obj/classes.dart';
import 'package:biblioteca_app/widgets/icon.dart';
import 'package:flutter/material.dart';

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
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
        color: const Color.fromARGB(255, 110, 160, 213),
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

class LibraryList extends StatelessWidget {
  final Library library;
  const LibraryList({
    super.key,
    required this.library,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return LibraryPage(
                library: library,
              );
            },
          ),
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
        color: const Color.fromARGB(255, 46, 110, 58),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: 80,
              child: Image.network(
                library.image.split(',')[0],
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset('assets/yuri.jpg'),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: Text(
                      library.name,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getLimitedAuthors(library.address),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 196, 188, 188)),
                      )
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

String _getLimitedAuthors(String authors) {
  // Limitar o autor a 20 caracteres
  if (authors.length > 20) {
    return '${authors.substring(0, 20)}...';
  }
  return authors;
}
