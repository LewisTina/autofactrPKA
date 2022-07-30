import 'package:autofact/body.dart';
import 'package:flutter/material.dart';

class Corp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('FactAuto',
            style: TextStyle(
              fontFamily: 'Century Gothic',
              fontWeight: FontWeight.w400,
            )),
        backgroundColor: Color(0xFF2E3191),
        elevation: 0.0,
      ),
      body: Body(),
    );
  }
}
