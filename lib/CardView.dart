import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  CardView({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(24.0, 71.0),
            child: Container(
              width: 324.0,
              height: 143.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.0),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 0),
                    blurRadius: 11,
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(39.0, 89.0),
            child: Container(
              width: 295.0,
              height: 46.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: const Color(0xffeaeaea),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(39.0, 152.0),
            child: Container(
              width: 295.0,
              height: 46.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: const Color(0xffeaeaea),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
