import 'package:http/http.dart' as http;
import 'package:chat_socket/global/enviroments.dart';
import 'package:chat_socket/services/auth_service.dart';
import 'package:chat_socket/models/usuario.dart';
import 'package:chat_socket/models/usuarios_response.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    // Hacemos la petición a la base de datos de los usuarios
    try {
      final resp = await http.get('${Enviroments.apiUrl}/usuarios', headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });
      // Mapeamos la respuesta
      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
