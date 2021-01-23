import 'package:flutter/material.dart';
import 'package:chat_socket/pages/chat_page.dart';
import 'package:chat_socket/pages/loading_page.dart';
import 'package:chat_socket/pages/login_page.dart';
import 'package:chat_socket/pages/register_page.dart';
import 'package:chat_socket/pages/user_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'user': (_) => UserPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};
