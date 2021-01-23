import 'package:flutter/material.dart';
import 'package:chat_socket/widgets/custom_buttom.dart';
import 'package:chat_socket/widgets/custom_input.dart';
import 'package:chat_socket/widgets/labels.dart';
import 'package:chat_socket/widgets/logo.dart';

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

          //TODO: Crear Boton
          CustomButtom(
              text: 'Crear cuenta',
              onPressed: () {
                print(
                    'Valores leídos: ${nameCtrl.text} ${emailCtrl.text} ${passCtrl.text}');
              }),
        ],
      ),
    );
  }
}
