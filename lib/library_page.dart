import 'package:biblioteca_app/obj/classes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  for (String i in library.image.split(','))
                    SizedBox(
                      width: 170,
                      height: 200,
                      child: Image.network(
                        i,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/yuri.jpg'),
                      ),
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
              Center(
                child: ElevatedButton.icon(
                    onPressed: () {
                      String googleMapsUrl =
                          'https://www.google.com/maps/search/?api=1&query=${library.lat},${library.long}';
                      launchUrl(Uri.parse(googleMapsUrl),
                          mode: LaunchMode.externalApplication);
                    },
                    icon: const Icon(Icons.location_on),
                    label: const Text('Abrir no Maps')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
