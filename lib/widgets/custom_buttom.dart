import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  

  final Function onPressed;
  final String text;

  const CustomButtom({
    @required this.text, @required this.onPressed,
  });


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
       onPressed: this.onPressed,
      child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(this.text, style: TextStyle(color: Colors.white, fontSize: 17 ),),
            ),
        ),
     );
  }
}
