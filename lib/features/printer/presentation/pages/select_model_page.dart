import 'package:autofact/features/printer/presentation/widgets/printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SelectModelPage extends StatefulWidget {
  const SelectModelPage({Key key}) : super(key: key);
  static const routeName = '/extractArguments';
  @override
  _SelectModelPageState createState() => _SelectModelPageState();
}

class _SelectModelPageState extends State<SelectModelPage> {
  int _modelId = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Choix du modèle',
            style: TextStyle(
              fontFamily: 'Century Gothic',
              fontWeight: FontWeight.w400,
            )),
        centerTitle: true,
        backgroundColor: Color(0xFF2E3191),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _modelId = 1;
                      });
                    },
                    child: Container(
                      height: size.height * .2,
                      width: size.width * .46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:
                              _modelId == 1 ? Color(0xFF2E3191) : Colors.white),
                      child: Text('Facture'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Century Gothic',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: _modelId == 1 ? Colors.white : Colors.black,
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _modelId = 2;
                      });
                    },
                    child: Container(
                      height: size.height * .2,
                      width: size.width * .46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:
                              _modelId == 2 ? Color(0xFF2E3191) : Colors.white),
                      child: Text('Devis'.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Century Gothic',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color:
                                  _modelId == 2 ? Colors.white : Colors.black)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                setState(() {
                  _modelId = 3;
                });
              },
              child: Container(
                height: size.height * .2,
                width: double.maxFinite,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: _modelId == 3 ? Color(0xFF2E3191) : Colors.white),
                child: Text('attestations'.toUpperCase(),
                    style: TextStyle(
                        fontFamily: 'Century Gothic',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: _modelId == 3 ? Colors.white : Colors.black)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * .35),
              child: Center(
                  child: InkWell(
                onTap: () {
                  if ([1, 2, 3].contains(_modelId)) {
                    Navigator.push(context, Printer(formatModel: _modelId));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF2E3191).withOpacity(.8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Century Gothic',
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                          )),
                      Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)
                    ],
                  ),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
