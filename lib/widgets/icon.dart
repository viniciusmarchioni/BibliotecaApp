import 'package:biblioteca_app/obj/classes.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  final int bookId;
  const Favorite({Key? key, required this.bookId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FavoriteState();
  }
}

class _FavoriteState extends State<Favorite> {
  late int bookId;
  late Future<bool> isFavorite;

  @override
  void initState() {
    super.initState();
    bookId = widget.bookId;
    isFavorite = _activeFavorite(bookId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return bookId != 0
        ? FutureBuilder<bool>(
            future: isFavorite,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (snapshot.hasError) {
                  return const Icon(Icons.star_border_rounded);
                } else {
                  return IconButton(
                    onPressed: () async {
                      bool favorite = await isFavorite;
                      if (!favorite) {
                        Account.setFavorite(bookId.toString());
                      } else {
                        Account.deleteFavorite(bookId.toString());
                      }
                      setState(() {
                        isFavorite = Future<bool>.value(!favorite);
                      });
                    },
                    icon: snapshot.data == true
                        ? const Icon(Icons.star_rate_rounded,
                            color: Colors.yellow)
                        : const Icon(Icons.star_border_rounded),
                  );
                }
              }
            },
          )
        : Container();
  }
}

Future<bool> _activeFavorite(String id) async {
  List<String>? lista = await Account.getFavorite();

  if (lista != null) {
    if (lista.contains(id)) {
      return true;
    }
    return false;
  }
  return false;
}
