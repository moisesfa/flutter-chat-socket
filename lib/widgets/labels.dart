import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String route;
  final String label1;
  final String label2;


  const Labels({
    @required this.route, 
    this.label1, 
    this.label2
    });
  

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
          Text(this.label1, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),),
          SizedBox(height: 10,),
          GestureDetector(
            child: Text(this.label2, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold),),
            onTap: (){
              Navigator.pushReplacementNamed(context, this.route);
            },
            ),
          
        ],
      ),
    );
  }
}