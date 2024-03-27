import 'package:biblioteca_app/menu.dart';
import 'package:biblioteca_app/obj/account.dart';
import 'package:biblioteca_app/obj/classes.dart';
import 'package:custom_signin_buttons/button_data.dart';
import 'package:custom_signin_buttons/button_list.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (await Account.isLogged()) {
    runApp(MaterialApp(home: Menu()));
  } else {
    runApp(const MaterialApp(home: MyApp()));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _Homepage();
}

class _Homepage extends State<MyApp> {
  void changeStr() {
    setState(() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            return Menu();
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
          child: SignInButton(
            button: Button.Google,
            text: 'Entrar com Google',
            width: 250,
            onPressed: () async {
              try {
                var user = await GoogleSignInApi.login();
                Account.saveAccount(Account(user?.displayName, user?.email));
                changeStr();
              } catch (e) {
                debugPrint("ERRO AQUI Ó: $e --------------------------");
              }
            },
          ),
        ),
      ),
    );
  }
}
