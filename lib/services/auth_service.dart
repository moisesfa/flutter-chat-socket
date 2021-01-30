import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_socket/global/enviroments.dart';
import 'package:chat_socket/models/login_response.dart';
import 'package:chat_socket/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;
  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final databody = {'email': email, 'password': password};
    final resp = await http.post('${Enviroments.apiUrl}/login',
        body: jsonEncode(databody),
        headers: {'Content-Type': 'application/json'});
    debugPrint(resp.body);
    this.autenticando = false;
    // Si la respuesta es correcta
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      //Guardar token en un lugar seguro
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    this.autenticando = true;
    final databody = {'nombre': name, 'email': email, 'password': password};
    final resp = await http.post('${Enviroments.apiUrl}/login/new',
        body: jsonEncode(databody),
        headers: {'Content-Type': 'application/json'});
    debugPrint(resp.body);
    this.autenticando = false;
    // Si la respuesta es correcta
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      //Guardar token en un lugar seguro
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  // Getters del token de forma estatica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    return await _storage.read(key: 'token');
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  // Función que verifique que el token almacenado todavia es válido
  Future<bool> isLoggedIn() async {
    // leo el token
    final token = await _storage.read(key: 'token');
    //print(token);
    // Compruebo si es valido
    final resp = await http.get('${Enviroments.apiUrl}/login/renew',
        headers: {'Content-Type': 'application/json', 'x-token': token});
    debugPrint(resp.body);
    // Si la respuesta es correcta
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      //Guardar token en un lugar seguro
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    // Write value
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    // Delete value
    await _storage.delete(key: 'token');
  }
}
