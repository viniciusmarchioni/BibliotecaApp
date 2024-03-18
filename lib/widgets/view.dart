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
            onTap: () {},
            child: Ink.image(
              image: const AssetImage('assets/yuri.jpg'),
              child: const Center(
                child: Text(
                  'Yuri Alberto',
                  style: TextStyle(
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
  final Livro book;
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
                livro: Livro(
                    titulo: book.titulo,
                    autores: book.autores,
                    sinopse: book.sinopse,
                    tema: book.tema,
                    imageUrl: book.imageUrl),
              );
            },
          ),
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
        color: Colors.blue,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(book.imageUrl),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: Text(
                      book.titulo,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    book.autores,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 196, 188, 188)),
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
