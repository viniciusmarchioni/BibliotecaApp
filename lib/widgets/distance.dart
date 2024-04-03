import 'dart:async';
import 'dart:math';

import 'package:biblioteca_app/obj/account.dart';
import 'package:flutter/material.dart';

class Distance extends StatefulWidget {
  const Distance({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DistanceState();
}

class _DistanceState extends State<Distance> {
  @override
  Widget build(BuildContext context) {
    return texto(context);
  }
}

String _kmCalculator(double lat, double long) {
  var lat2 = -23.70988417420099;
  var long2 = -46.55288483636871;
  var dlat = _toRadians(lat2 - lat);
  var dlon = _toRadians(long2 - long);

  var a = pow(sin(dlat / 2), 2) +
      cos(_toRadians(lat)) * cos(_toRadians(lat2)) * pow(sin(dlon / 2), 2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  var distance = 6371.0 * c;
  if (distance > 100) {
    return '>100';
  }
  return distance.toStringAsFixed(1);
}

double _toRadians(double degree) {
  return degree * pi / 180;
}

Widget texto(context) {
  return FutureBuilder<Widget>(
    future: getLocations(context),
    builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Retorna um widget de carregamento enquanto o futuro está sendo resolvido
        return const CircularProgressIndicator();
      } else {
        // Retorna o widget resolvido do futuro
        return snapshot.data ??
            Container(); // Se snapshot.data for nulo, retorna um Container()
      }
    },
  );
}

Future<Widget> getLocations(context) async {
  double? lat = await Account.getLatitude();
  double? long = await Account.getLongitude();

  if (lat == null || long == null) {
    return Container();
  }

  return Container(
    margin: const EdgeInsets.only(right: 15),
    child: Text(
      '${_kmCalculator(lat, long)} km',
      style: const TextStyle(color: Color.fromARGB(255, 196, 188, 188)),
    ),
  );
}
