import 'package:biblioteca_app/menu.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _Homepage();
}

class _Homepage extends State<MyApp> {
  final TextEditingController _textController = TextEditingController();

  void changeStr() {
    setState(() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            return const Menu();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _textController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: 'Entrar como',
                      border: const OutlineInputBorder(),
                      fillColor: Colors.black,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _textController.clear();
                          },
                          icon: const Icon(Icons.clear))),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: changeStr,
                  style: const ButtonStyle(),
                  child: const Text('Entrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
