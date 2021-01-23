import 'package:flutter/material.dart';


class ChatMessage extends StatelessWidget {

  final String texto;
  final String uid;
  final AnimationController animationController;
  

  const ChatMessage({
    @required this.texto, 
    @required this.uid, 
    @required this.animationController});

  
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: this.uid == '123' ? _myMessage() : _notMyMessage(),
          
        ),
      ),
    );
  }

  Widget _myMessage(){

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 5, left: 50, right: 5),
        padding:  EdgeInsets.all(8.0),
        child: Text(this.texto, style: TextStyle(color: Colors.white),),
        decoration: BoxDecoration(
          color: Color(0xff4d9ef6),
          borderRadius: BorderRadius.circular(20)
          ),
        ),
    );

  }

  Widget _notMyMessage(){

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 5, right: 50, left: 5),
        padding:  EdgeInsets.all(8.0),
        child: Text(this.texto, style: TextStyle(color: Colors.black87),),
        decoration: BoxDecoration(
          color: Color(0xffe4e5e8),
          borderRadius: BorderRadius.circular(20)
          ),
        ),
    );

  }

}