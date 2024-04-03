import 'package:biblioteca_app/main.dart';
import 'package:biblioteca_app/obj/account.dart';
import 'package:biblioteca_app/search_page.dart';
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
