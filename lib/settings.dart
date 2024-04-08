import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State {
  bool songs = false;
  bool vibration = false;
  bool notification = false;

  @override
  void initState() {
    super.initState();
    _inicio();
  }

  _inicio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      songs = prefs.getBool('Song') ?? false;
      vibration = prefs.getBool('Vibration') ?? false;
      notification = prefs.getBool('Notif') ?? false;
    });
  }

  void _changeSong(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Song', value);
  }

  void _changeNotif(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Notif', value);
  }

  void _changeVibration(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Vibration', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.music_note),
                Switch(
                  activeTrackColor: const Color.fromARGB(255, 110, 160, 213),
                  value: songs,
                  onChanged: (value) {
                    setState(() {
                      songs = value;
                      _changeSong(value);
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.vibration),
                Switch(
                  activeTrackColor: const Color.fromARGB(255, 110, 160, 213),
                  value: vibration,
                  onChanged: (value) {
                    setState(() {
                      vibration = value;
                      _changeVibration(value);
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.notifications_active),
                Switch(
                  activeTrackColor: const Color.fromARGB(255, 110, 160, 213),
                  value: notification,
                  onChanged: (value) {
                    setState(() {
                      notification = value;
                      _changeNotif(value);
                    });
                  },
                )
              ],
            ),
          ],
        ),
        Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Center(
                child: TextButton(
                    onPressed: () {}, child: const Text('---Sobre---'))))
      ]),
    );
  }
}
