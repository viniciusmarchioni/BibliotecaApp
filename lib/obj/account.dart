import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account {
  String? nome;
  String? email;

  Account(this.nome, this.email);

  static Future<void> saveAccount(Account conta) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (conta.nome != null) {
      await prefs.setString('name', conta.nome!);
    } else {
      throw ('Invalid name');
    }

    if (conta.email != null) {
      await prefs.setString('email', conta.email!);
    } else {
      throw ('Invalid email');
    }
  }

  static Future<bool> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final String? name = prefs.getString('name');
      final String? email = prefs.getString('email');
      return (name != null &&
          email != null &&
          name.isNotEmpty &&
          email.isNotEmpty);
    } catch (e) {
      return false;
    }
  }

  static Future<Account> getAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString('name');
    final String? email = prefs.getString('email');
    return Account(name, email);
  }

  static Future<void> setFavorite(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      List<String>? lista = prefs.getStringList('favoritos');
      if (lista == null) {
        await prefs.setStringList('favoritos', <String>[id]);
      } else {
        await prefs.setStringList('favoritos', <String>[id, ...lista]);
      }
    } catch (e) {
      await prefs.setStringList('favoritos', <String>[id]);
    }
  }

  static Future<List<String>?> getFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favoritos');
  }

  static Future<void> deleteFavorite(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      List<String>? lista = prefs.getStringList('favoritos');
      if (lista != null && lista.contains(id)) {
        lista.remove(id);
        await prefs.setStringList('favoritos', lista);
      }
    } catch (e) {
      debugPrint('Error deleting favorite: $e');
    }
  }

  static Future<void> deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
  }

  static Future<void> setPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Position posicao = await _posicaoAtual();
      await prefs.setDouble('lat', posicao.latitude);
      await prefs.setDouble('long', posicao.longitude);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<double?> getLatitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getDouble('lat') == null) {
        throw ('Erro em obter longitude');
      }
      return prefs.getDouble('lat');
    } catch (e) {
      throw ('Erro em obter latitude');
    }
  }

  static Future<double?> getLongitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getDouble('long') == null) {
        throw ('Erro em obter longitude');
      }
      return prefs.getDouble('long');
    } catch (e) {
      throw ('Erro em obter longitude');
    }
  }
}

Future<Position> _posicaoAtual() async {
  LocationPermission permissao;

  bool ativado = await Geolocator.isLocationServiceEnabled();
  if (!ativado) {
    return Future.error('Por favor, habilite a localização no smartphone');
  }

  permissao = await Geolocator.checkPermission();
  if (permissao == LocationPermission.denied) {
    permissao = await Geolocator.requestPermission();
    if (permissao == LocationPermission.denied) {
      return Future.error('Você precisa autorizar o acesso à localização');
    }
  }

  if (permissao == LocationPermission.deniedForever) {
    return Future.error('Você precisa autorizar o acesso à localização');
  }

  return await Geolocator.getCurrentPosition();
}
