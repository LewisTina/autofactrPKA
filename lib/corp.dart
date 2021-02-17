import 'package:flutter/material.dart';
import 'package:autofact/body.dart';

class Corp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title:
        Text('Facturation Automatique',
              style: TextStyle(fontFamily: 'Century Gothic',fontWeight: FontWeight.w400,)
        ),
        backgroundColor: Color(0xFF7451eb),
        elevation: 0.0,
      ),

      body: Body(),
    );
  }
}