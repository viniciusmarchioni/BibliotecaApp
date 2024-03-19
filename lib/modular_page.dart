import 'package:biblioteca_app/obj/classes.dart';
import 'package:flutter/material.dart';

class ModularPage extends StatefulWidget {
  final Livro livro;
  const ModularPage({super.key, required this.livro});

  @override
  State<StatefulWidget> createState() {
    return _Estado();
  }
}

class _Estado extends State<ModularPage> {
  late Livro livro;
  bool isActived = false;

  @override
  void initState() {
    livro = widget.livro;
    super.initState();
  }

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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                if (livro.imageUrl == '')
                  Image.network(livro.imageUrl)
                else
                  Image.network(
                      'https://pbs.twimg.com/media/GGxpGBKXAAAkdwf?format=jpg&name=small')
              ]),
              Text(
                livro.autores,
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 173, 165, 165)),
              ),
              Text(
                livro.sinopse,
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
                      : const Icon(Icons.arrow_drop_down_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
