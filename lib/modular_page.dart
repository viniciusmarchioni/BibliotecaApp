import 'package:biblioteca_app/obj/classes.dart';
import 'package:flutter/material.dart';

class ModularPage extends StatelessWidget {
  final Livro livro;

  const ModularPage({super.key, required this.livro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 119, 156),
      appBar: AppBar(
        title: Text(livro.titulo),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.network(livro.imageUrl)]),
              Text(
                livro.autores,
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 173, 165, 165)),
              ),
              Text(
                livro.sinopse,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
