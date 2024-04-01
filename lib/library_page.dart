import 'package:biblioteca_app/obj/classes.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  final Library library;

  const LibraryPage({Key? key, required this.library}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 46, 110, 58),
      appBar: AppBar(
        title: Text(library.name),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                child: Scrollbar(
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                  SizedBox(
                    width: 170,
                    height: 200,
                    child: Image.network(library.image.toString()),
                  ),
                  SizedBox(
                    width: 170,
                    height: 200,
                    child: Image.network(library.image.toString()),
                  ),
                  SizedBox(
                    width: 170,
                    height: 200,
                    child: Image.network(library.image.toString()),
                  ),
                ])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  library.address,
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
