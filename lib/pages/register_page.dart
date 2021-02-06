import 'package:chat_socket/helpers/mostar_alerta.dart';
import 'package:chat_socket/services/auth_service.dart';
import 'package:chat_socket/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_socket/widgets/custom_buttom.dart';
import 'package:chat_socket/widgets/custom_input.dart';
import 'package:chat_socket/widgets/labels.dart';
import 'package:chat_socket/widgets/logo.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(
                    title: 'Registro',
                  ),
                  _Form(),
                  Labels(
                    route: 'login',
                    label1: '¿Ya tienes cuenta?',
                    label2: 'Inicia sesión',
                  ),
                  Text(
                    'Terminios y condiciones de uso.',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            //keyboardType: TextInputType.emailAddress,
            textController: nameCtrl,
          ),

          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            textController: passCtrl,
            isPassword: true,
          ),

          // Crear Boton
          CustomButtom(
              text: 'Crear cuenta',
              onPressed: authService.autenticando
                  ? null
                  : () async {
                      print(
                          'Valores leídos: ${nameCtrl.text} ${emailCtrl.text} ${passCtrl.text}');
                      FocusScope.of(context)
                          .unfocus(); // Para que desaparezca el teclado
                      final registerOk = await authService.register(
                          nameCtrl.text.trim(),
                          emailCtrl.text.trim(),
                          passCtrl.text.trim());
                      if (registerOk == true) {
                        // Conectar a nuestro socket server
                        socketService.connectSocket();
                        // Navegamos a otra pantalla
                        Navigator.pushReplacementNamed(context, 'users');
                      } else {
                        mostrarAlerta(
                            context, 'Registro incorrecto', registerOk);
                      }
                    }),
        ],
      ),
    );
  }
}
