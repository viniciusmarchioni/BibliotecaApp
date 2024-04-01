import 'package:biblioteca_app/obj/classes.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  final Book livro;

  const LibraryPage({Key? key, required this.livro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 46, 110, 58),
      appBar: AppBar(
        title: Text(livro.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 200,
                      child: Image.network(livro.imageUrl),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 200,
                      child: Image.network(livro.imageUrl),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  livro.authors,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 173, 165, 165),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
