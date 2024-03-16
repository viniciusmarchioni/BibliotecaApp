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
  final bool livro;
  final String titulo;
  final String autores;
  const ItemList(
      {super.key,
      required this.livro,
      required this.titulo,
      required this.autores});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('object');
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
        color: livro ? Colors.blue : Colors.green,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
              image: AssetImage('assets/yuri.jpg'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  autores,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 196, 188, 188)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
