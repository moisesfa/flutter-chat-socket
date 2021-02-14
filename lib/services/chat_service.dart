import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_socket/models/usuario.dart';
import 'package:chat_socket/global/enviroments.dart';
import 'package:chat_socket/services/auth_service.dart';
import 'package:chat_socket/models/mensajes_response.dart';

class ChatService with ChangeNotifier {
  Usuario usuarioChat;

  Future<List<Mensaje>> getMensajes(String usuarioID) async {
    try {
      final resp = await http.get('${Enviroments.apiUrl}/mensajes/$usuarioID',
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          });
      // Mapeamos la respuesta
      final mensajesResponse = mensajesResponseFromJson(resp.body);
      return mensajesResponse.mensajes;
    } catch (e) {
      return [];
    }
  }
}
