import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:autofact/number_to_letter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'features/printer/models/certificateData.dart';
import 'features/printer/presentation/pages/select_model_page.dart';
import 'features/printer/presentation/widgets/certificate_form.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  static var FactOrProfNumber;
  static var jour;
  static var Numero;
  static bool isFact = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bool isFact = true;
    const locale = "fr";
    final dateTimeFormat = DateFormat.yMMMMd(locale);
    var DateDuJour = new DateTime.now();
    String maChaine = DateFormat('hh yy MM ss').format(DateDuJour);
    jour = 'Yaoundé le ' + dateTimeFormat.format(DateDuJour);

    Numero = maChaine.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    const State1 = 'assets/Svg/StatesBars_1.svg';

    return SingleChildScrollView(
        child: Center(
      child: Column(children: <Widget>[
        SvgPicture.asset(
          State1,
        ),

        Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            DateOfMounth(),
            LiteRollingSwitch(
              value: false,
              textOn: 'Attestation',
              textOff: 'Facture/Devis',
              colorOn: Color(0xFF0071E3),
              colorOff: Color(0xFF2E3191),
              iconOn: Icons.edit,
              iconOff: Icons.print,
              onChanged: (bool state) {
                FactOrProfNumber = '$Numero';
                isFact = !state;
                print("is fact : $isFact");
                if (isFact == false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CertificateForm()));
                }
              },
            ),
          ]),
        ),
        FractionallySizedBox(
          widthFactor: 0.95,
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.only(
              bottom: 25,
              left: 15,
              right: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color(0x17004eff),
            ),
            child: Column(children: <Widget>[
              BasicInformations(),
            ]),
          ),
        ),

        RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          onPressed: () {
            Navigator.push(context, InfosCommande());
          },
          color: Color(0xFF0071E3),
          textColor: Colors.white,
          label: Text(
            isFact == true ? 'Information Sur Produits' : "Générer",
            style: TextStyle(
              fontFamily: 'Century Gothic',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          icon: Icon(Icons.assignment),
        ),

        // Container(
        //     width: double.infinity,
        //     height: 50.0,
        //     padding: EdgeInsets.all(5),
        //     margin: EdgeInsets.only(top: 100),
        //     decoration: BoxDecoration(
        //       color: const Color(0x59acacac),
        //     ),
        //
        //       child: Text(
        //         'Powered by TinArt © & Designed By Lewis TINA\nL2 Student\'s software Engineering',
        //         style: TextStyle(
        //           fontFamily: 'Century Gothic',
        //           fontSize: 15,
        //           color: const Color(0xff000000),
        //           fontWeight: FontWeight.w700,
        //         ),
        //         textAlign: TextAlign.center,
        //     ),
        //   ),
      ]),
    ));
  }
}

// Creation du block des Dates
class DateOfMounth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime actuel = new DateTime.now();
    String formattedDate = DateFormat('EEEE d MMMM').format(actuel);
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 35.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          gradient: LinearGradient(
            colors: [Color(0xFF2E3191), Color(0xFF0071E3)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xc9aaaaaa),
              offset: Offset(0, 3),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            formattedDate,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Century Gothic',
              //fontSize: 20,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w700,
              //height: 0.85,
            ),
          ),
        ),
      ),
    );
  }
}

// Information Basiques sur la facture
class BasicInformations extends StatefulWidget {
  BasicInformations({Key key}) : super(key: key);

  @override
  _BasicInformations createState() => _BasicInformations();
}

class _BasicInformations extends State<BasicInformations> {
  var doit = TextEditingController();
  var objet = TextEditingController();
  var adresse = TextEditingController();
  var devoir = '';
  var ob = '';
  var ad = '';
  var firstname = '';
  var lastname = '';
  var startDate = '';
  var endDate = "";
  static _BasicInformations globalInstance = new _BasicInformations();

  _onChanged(String value) {
    globalInstance.devoir = value;
  }

  _onChanged2(String value) {
    globalInstance.ob = value;
  }

  _onChanged3(String value) {
    globalInstance.ad = value;
  }

  static FractionallySizedBox createView() {
    return FractionallySizedBox(
      widthFactor: 0.95,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.0),
              color: const Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 0),
                  blurRadius: 11,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(13),
                  height: 46.0,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0xffeaeaea),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.assignment_ind,
                        color: Color(0xFF0071E3),
                      ),
                      SizedBox(width: 10),
                      Text(
                        globalInstance.devoir, //Body.objet.text,
                        style: TextStyle(
                          fontFamily: 'Century Gothic',
                          color: Color(0x60004eff),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    globalInstance.devoir = '';
    globalInstance.ob = '';
    globalInstance.ad = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Visibility(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              TextFormField(
                controller: doit,
                onChanged: (String value) {
                  _onChanged(value);
                },
                decoration: InputDecoration(
                  labelText: 'Doit',
                  prefixIcon: Icon(Icons.assignment_ind),
                ),
              ),
              TextFormField(
                controller: adresse,
                onChanged: (String value) {
                  _onChanged3(value);
                },
                decoration: InputDecoration(
                  labelText: 'Adresse',
                  prefixIcon: Icon(Icons.location_city_rounded),
                ),
              ),
              TextFormField(
                controller: objet,
                onChanged: (String value) {
                  _onChanged2(value);
                },
                decoration: InputDecoration(
                  labelText: 'Objet',
                  prefixIcon: Icon(Icons.style),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

// Page N°2 Pour l'insertion des Données
class InfosCommande extends MaterialPageRoute<void> {
  InfosCommande()
      : super(builder: (BuildContext context) {
          return Scaffold(
              backgroundColor: Color.fromRGBO(232, 239, 255, 1),
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Informations Sur La Comande',
                    style: TextStyle(
                      fontFamily: 'Century Gothic',
                      fontWeight: FontWeight.w400,
                    )),
                elevation: 0.0,
                backgroundColor: Color(0xFF2E3191),
              ),
              body: EditionTableau());
        });
}

// Container Adaptatif du Table Dynamique
class EditionTableau extends StatefulWidget {
  @override
  _EditionTableauState createState() => _EditionTableauState();
}

class _EditionTableauState extends State<EditionTableau> {
  //Creation des Tableaux de Collecte des Controller
  var Qte = <TextEditingController>[];
  var Designation = <TextEditingController>[];
  var Reduction = <TextEditingController>[];
  var PrixU = <TextEditingController>[];
  var PrixT = <TextEditingController>[];
  var ligne = <Column>[];
  var Produit = '';
  var Produit2 = '';
  var Montant = '';
  List<ElementEntry> entries;
  List<Product> donnees;
  static _EditionTableauState globalInstance2 = new _EditionTableauState();

  _Changed(String value) {
    globalInstance2.Montant = value;
  }

  _Changed2(String value) {
    Produit2 = value;
  }

//Creation de La Column contenat les differents Camps
  Column createColumn() {
    //1print(Produit);
    var QteController = TextEditingController();
    var DesignationController = TextEditingController();
    var reductionController = TextEditingController();
    var PrixUController = TextEditingController();
    var PrixTController = TextEditingController();
    Qte.add(QteController);
    Designation.add(DesignationController);
    Reduction.add(reductionController);
    PrixU.add(PrixUController);
    PrixT.add(PrixTController);

    //Création de la ligne mère
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: 35,
              child: TextField(
                controller: QteController,
                keyboardType: TextInputType.number,
                maxLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      bottom: 35 / 2,
                    )),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x170dc8ff),
              ),
              height: 35,
              child: TextField(
                controller: DesignationController,
                maxLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      bottom: 35 / 2,
                    )),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: 35,
              child: TextField(
                controller: PrixUController,
                maxLines: 1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      bottom: 35 / 2,
                    )),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x170dc8ff),
              ),
              height: 35,
              child: TextField(
                controller: reductionController,
                maxLines: 1,
                onChanged: (String value) {
                  _Changed2(value);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      bottom: 35 / 2,
                    )),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  @override
  void dispose() {
    globalInstance2.Montant = '';
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ligne.add(createColumn());
  }

  _onDone() {
    globalInstance2.donnees = [];

    for (int i = 0; i < ligne.length; i++) {
      var Num = (i + 1).toString();
      var designation = Designation[i].text;
      if (Designation[i].text.isEmpty) {
        designation = 'Non Mentionner';
      }
      ;

      var reduction = 0.00;

      var quantity = double.tryParse(Qte[i].text);
      if (Qte[i].text.isEmpty) {
        quantity = 0;
      }
      ;

      var price = double.tryParse(PrixU[i].text);
      if (PrixU[i].text.isEmpty) {
        price = 0;
      }
      ;

      globalInstance2.donnees.add(Product(Num, designation, quantity, price));
    }

    if (ligne.length >= 1) {
      var last = globalInstance2.donnees[ligne.length - 1].quantity;
      if (last == 0) {
        print('Champ Nom Saisi');
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xffeaeaea),
          elevation: 0,
          duration: Duration(milliseconds: 800),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Text(
            'Veuillez Remplir La Ligne Précédente',
            style: TextStyle(
              fontFamily: 'Century Gothic',
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ));
        return;
      }
    }

    setState(() {});
    ligne.add(createColumn());
  }

  _Done() {
    globalInstance2.donnees = [];
    if (Qte[0].text.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Color(0xffeaeaea),
        elevation: 0,
        duration: Duration(milliseconds: 800),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Text(
          'Cette Facture ne contient aucune quantité de produit',
          style: TextStyle(
            fontFamily: 'Century Gothic',
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ));
      return;
    }
    ;

    for (int i = 0; i < ligne.length; i++) {
      var Num = (i + 1).toString();
      var designation = Designation[i].text;
      if (Designation[i].text.isEmpty) {
        designation = 'Non Mentionner';
      }
      ;

      var reduction = double.tryParse(Reduction[i].text);
      if (Reduction[i].text.isEmpty) {
        reduction = 0;
      }
      ;

      var quantity = double.tryParse(Qte[i].text);

      var price = double.tryParse(PrixU[i].text);
      if (PrixU[i].text.isEmpty) {
        price = 0;
      }
      ;

      if (Qte[i].text.isNotEmpty) {
        globalInstance2.donnees.add(Product(Num, designation, quantity, price));
      }
    }

    //if(double.tryParse(globalInstance2.Montant) > Invoice._grandTotal){}
  }

  @override
  Widget build(BuildContext context) {
    const State2 = 'assets/Svg/StatesBars_2.svg';

    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.95,
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                State2,
              ),
              _BasicInformations.createView(),
              TableHead(),
              Expanded(
                child: ListView.builder(
                  itemCount: ligne.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ligne[index];
                  },
                ),
              ),
              Container(
                child: TextFormField(
                  onChanged: (String value) {
                    _Changed(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Montant Payé',
                    prefixIcon: Icon(Icons.style),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF2E3191),
        shape: CircularNotchedRectangle(),
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            top: 10,
            bottom: 10,
            right: 80,
          ),
          height: 50,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.white,
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            textColor: Color(0xFF2E3191),
            child: Text("Construire",
                style: TextStyle(
                  fontFamily: 'Century Gothic',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
            onPressed: () {
              _Done();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectModelPage()));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onDone,
        backgroundColor: Color(0xFF0071E3),
        child: Icon(Icons.add_box),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class ElementEntry {
  final String qte;
  final String designation;
  final String prixu;
  var prixt;

  ElementEntry(this.qte, this.designation, this.prixu, this.prixt);
  @override
  String toString() {
    return 'LigneCommande: Quantité= $qte, Désignation= $designation, Prix U= $prixu, Prix T= $prixt';
  }
}

// Creation des En-tete du Tableau Dynamique
class TableHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  height: 35,
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(12)),
                    color: Color(0xFF0071E3),
                  ),
                  child: Text(
                    "Qté",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Century Gothic',
                      color: const Color(0xfffffefe),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  height: 35,
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.white),
                        left: BorderSide(color: Colors.white)),
                    color: Color(0xFF0071E3),
                  ),
                  child: Text(
                    "Désignation",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Century Gothic',
                      color: const Color(0xfffffefe),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  height: 35,
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.white),
                        left: BorderSide(color: Colors.white)),
                    color: Color(0xFF0071E3),
                  ),
                  child: Text(
                    "Prix U.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Century Gothic',
                      color: const Color(0xfffffefe),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  height: 35,
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(12)),
                    color: Color(0xFF0071E3),
                  ),
                  child: Text(
                    "Réduc",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Century Gothic',
                      color: const Color(0xfffffefe),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}

Future<Uint8List> generateInvoice(PdfPageFormat pageFormat, int formatModel,
    {CertificateData data}) async {
  final invoice = Invoice(
    invoiceNumber: _BodyState.Numero,
    products: _EditionTableauState.globalInstance2.donnees,
    customerName: 'Abraham Swearegin',
    customerAddress: '54 rue de Rivoli\n75001 Paris, France',
    tax: .15,
    baseColor: PdfColors.teal,
    accentColor: PdfColors.blueGrey900,
  );

  return await invoice.buildPdf(pageFormat, formatModel, data);
}

class Invoice {
  Invoice({
    this.products,
    this.customerName,
    this.customerAddress,
    this.invoiceNumber,
    this.tax,
    this.baseColor,
    this.accentColor,
  });

  final List<Product> products;
  final String customerName;
  final String customerAddress;
  final String invoiceNumber;
  final double tax;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;
  var Num = _BodyState.FactOrProfNumber;
  var day = _BodyState.jour;

  PdfColor get _baseTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  double get _total =>
      products.map<double>((p) => p.total).reduce((a, b) => a + b);

  // double get _reduc =>
  //     products.map<double>((p) => p.reduction).reduce((a, b) => a + b);

  double get _grandTotal => _total;

  var montant = double.tryParse(_EditionTableauState.globalInstance2.Montant);

  var _aPaye;

  //String _logo;

  String _bgShape;
  String _chShape;
  String headerImg, footerImg;

  Future<Uint8List> buildPdf(
      PdfPageFormat pageFormat, int formatModel, CertificateData data) async {
    // Create a PDF document.
    final doc = pw.Document();

    final font1 = await rootBundle.load('assets/fonts/roboto1.ttf');
    final font2 = await rootBundle.load('assets/fonts/roboto2.ttf');
    final font3 = await rootBundle.load('assets/fonts/roboto3.ttf');

    switch (formatModel) {
      case 1:
        {
          //bg des factures
          _bgShape = await rootBundle.loadString('assets/Svg/Fond_GEG.svg');
          footerImg = await rootBundle.loadString('assets/Svg/Foot_GEG.svg');
          headerImg = await rootBundle.loadString('assets/Svg/Head_GEG.svg');
        }
        break;
      case 2:
        {
          //bg des devis
          _bgShape = await rootBundle.loadString('assets/Svg/FondE_GEG.svg');
          headerImg = await rootBundle.loadString('assets/Svg/Head_GEG.svg');
          footerImg = await rootBundle.loadString('assets/Svg/FootE_GEG.svg');
        }
        break;
      case 3:
        {
          //bg des attestations
          _bgShape = await rootBundle.loadString('assets/Svg/FondA_GEG.svg');
        }
        break;
    }

    _chShape = await rootBundle.loadString('assets/Svg/ContHd.svg');
    final _font = await PdfGoogleFonts.montserratBoldItalic();
    final _font2 = await PdfGoogleFonts.montserratMediumItalic();
    final _fontBold = await PdfGoogleFonts.montserratBold();
    final _fontRegular = await PdfGoogleFonts.montserratRegular();
    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
          pageTheme: _buildTheme(
            [1, 3].contains(formatModel)
                ? PdfPageFormat.a4.landscape
                : pageFormat,
            [1, 3].contains(formatModel)
                ? pw.PageOrientation.landscape
                : pw.PageOrientation.portrait,
            pw.Font.ttf(font1),
            pw.Font.ttf(font2),
            pw.Font.ttf(font3),
          ),
          header: formatModel == 1
              ? _buildHeader
              : formatModel == 2
                  ? _buildDevisHeader
                  : _buildAttestationHeader,
          footer: formatModel == 1
              ? _buildFooter
              : formatModel == 2
                  ? _buildDevisFooter
                  : _buildAttestionFooter,
          build: (context) => [
                formatModel == 1
                    ? _contentHeader(context, _fontBold, _fontRegular, _font2)
                    : formatModel == 2
                        ? _contentDevisHeader(
                            context, _fontBold, _fontRegular, _font2)
                        : _contentAttestationHeader(context),
                formatModel == 1
                    ? _contentTable(context, _fontBold, _fontRegular)
                    : formatModel == 2
                        ? _contentDevisTable(context, _fontBold, _fontRegular)
                        : _contentAttestationTable(context),
                pw.SizedBox(height: 20),
                formatModel == 1
                    ? _contentDevisFooter(context, _font2, _font)
                    : formatModel == 2
                        ? _contentDevisFooter(context, _font2, _font)
                        : _contentAttestationFooter(context, _font, _font2,
                            data: data),
                pw.SizedBox(height: 20),
              ]),
    );

    // Return the PDF file content
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(await doc.save());
    return doc.save();
  }

  pw.Widget _buildDevisHeader(pw.Context context) {
    return pw.Stack(children: <pw.Widget>[
      pw.SvgImage(svg: headerImg),
      pw.Container(
        margin: pw.EdgeInsets.only(left: 385, top: 31.5),
        child: pw.RichText(
          text: pw.TextSpan(
              text: "DEVIS N° ".toUpperCase(),
              style: pw.TextStyle(
                // font: _fontBold,
                fontSize: 15,
                color: PdfColors.black,
                fontWeight: pw.FontWeight.bold,
              ),
              children: [
                pw.TextSpan(
                  text: "$Num".toUpperCase(),
                  style: pw.TextStyle(
                    // font: font,
                    fontSize: 15,
                    color: PdfColor.fromInt(0xFF0071E3),
                    fontWeight: pw.FontWeight.bold,
                  ),
                )
              ]),
          textAlign: pw.TextAlign.left,
        ),
      ),
    ]);
  }

  pw.Widget _buildAttestationHeader(pw.Context context) {
    return pw.Container();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Stack(children: <pw.Widget>[
      pw.SvgImage(svg: headerImg),
      pw.Container(
        margin: pw.EdgeInsets.only(left: 600, top: 50),
        child: pw.RichText(
          text: pw.TextSpan(
              text: "FACTURE N° ".toUpperCase(),
              style: pw.TextStyle(
                // font: _fontBold,
                fontSize: 15,
                color: PdfColors.black,
                fontWeight: pw.FontWeight.bold,
              ),
              children: [
                pw.TextSpan(
                  text: "$Num".toUpperCase(),
                  style: pw.TextStyle(
                    // font: font,
                    fontSize: 15,
                    color: PdfColor.fromInt(0xFF0071E3),
                    fontWeight: pw.FontWeight.bold,
                  ),
                )
              ]),
          textAlign: pw.TextAlign.left,
        ),
      ),
    ]);
  }

  pw.Widget _buildDevisFooter(pw.Context context) {
    return pw.SvgImage(svg: footerImg);
  }

  pw.Widget _buildAttestionFooter(pw.Context context) {
    return pw.Container();
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(child: pw.SvgImage(svg: footerImg));
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat,
      pw.PageOrientation orientation,
      pw.Font base,
      pw.Font bold,
      pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      margin: pw.EdgeInsets.only(left: 20, right: 20, bottom: 30),
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.SvgImage(svg: _bgShape),
      ),
    );
  }

  pw.Widget _contentHeader(pw.Context context, dynamic font,
      dynamic fontRegular, dynamic fontItalic) {
    return pw.Column(
      children: <pw.Widget>[
        pw.Container(
          margin: pw.EdgeInsets.only(left: 620),
          child: pw.RichText(
            text: pw.TextSpan(
              text: _BodyState.jour,
              style: pw.TextStyle(
                font: fontItalic,
                fontSize: 11,
                decoration: pw.TextDecoration.underline,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
            textAlign: pw.TextAlign.right,
          ),
        ),
        pw.Container(
          margin: pw.EdgeInsets.only(top: 35, left: 10),
          alignment: pw.Alignment.centerLeft,
          child: pw.RichText(
            text: pw.TextSpan(
              style: pw.TextStyle(
                fontSize: 12,
                color: PdfColors.black,
              ),
              children: [
                pw.TextSpan(
                  text: 'Doit:   ',
                  style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
                pw.TextSpan(
                  text: _BasicInformations.globalInstance.devoir.toUpperCase() +
                      '\n',
                  style: pw.TextStyle(
                    font: fontRegular,
                  ),
                ),
                pw.TextSpan(
                  text: 'Objet:   ',
                  style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
                pw.TextSpan(
                  text: _BasicInformations.globalInstance.ob.toUpperCase(),
                  style: pw.TextStyle(
                    font: fontRegular,
                  ),
                ),
              ],
            ),
            textAlign: pw.TextAlign.left,
          ),
        ),
      ],
    );
  }

  pw.Widget _contentDevisHeader(pw.Context context, dynamic font,
      dynamic fontRegular, dynamic fontItalic) {
    return pw.Column(
      children: <pw.Widget>[
        pw.Container(
          margin: pw.EdgeInsets.only(
            left: 375,
          ),
          child: pw.RichText(
            text: pw.TextSpan(
              text: _BodyState.jour,
              style: pw.TextStyle(
                font: fontItalic,
                fontSize: 11,
                decoration: pw.TextDecoration.underline,
                fontStyle: pw.FontStyle.italic,
              ),
            ),
            textAlign: pw.TextAlign.left,
          ),
        ),
        pw.Container(
          margin: pw.EdgeInsets.only(top: 35, left: 10),
          alignment: pw.Alignment.centerLeft,
          child: pw.RichText(
            text: pw.TextSpan(
              style: pw.TextStyle(
                fontSize: 12,
                color: PdfColors.black,
              ),
              children: [
                pw.TextSpan(
                  text: 'Doit:   ',
                  style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                    //font: Gothic,
                  ),
                ),
                pw.TextSpan(
                  text: _BasicInformations.globalInstance.devoir.toUpperCase() +
                      '\n',
                  style: pw.TextStyle(
                    font: fontRegular,
                  ),
                ),
                pw.TextSpan(
                  text: 'Objet:   ',
                  style: pw.TextStyle(
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
                pw.TextSpan(
                  text: _BasicInformations.globalInstance.ob.toUpperCase(),
                  style: pw.TextStyle(
                    font: fontRegular,
                  ),
                ),
              ],
            ),
            textAlign: pw.TextAlign.left,
          ),
        ),
      ],
    );
  }

  pw.Widget _contentAttestationHeader(pw.Context context) {
    return pw.Container();
  }

  pw.Widget _contentFooter(pw.Context context) {
    if (montant == null) {
      montant = 0;
    }

    if (montant > _grandTotal) {
      _aPaye =
          'Le Montant Que vous encaissez est superieur au montant à payer veuillez vérifier';
    } else {
      _aPaye = _grandTotal - montant;
    }
    return pw.Column(children: [
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 1,
            child: pw.DefaultTextStyle(
              style: const pw.TextStyle(
                fontSize: 10,
                color: _darkColor,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Sous Total:'),
                      pw.Text(_formatCurrency(_total)),
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  // pw.Row(
                  //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     pw.Text('Réduction:'),
                  //     pw.Text('$_reduc'),
                  //   ],
                  // ),
                  pw.Divider(color: accentColor),
                  pw.DefaultTextStyle(
                    style: pw.TextStyle(
                      color: PdfColor.fromInt(0xFF0071E3),
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Total:'),
                        pw.Text(_formatCurrency(_grandTotal)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      pw.SizedBox(height: 30),
      pw.Row(children: [
        pw.Expanded(
            child: pw.Container(
          height: 50,
          padding: pw.EdgeInsets.all(2.5),
          child: pw.RichText(
            text: pw.TextSpan(
              style: pw.TextStyle(
                fontSize: 12,
                color: PdfColors.black,
              ),
              children: [
                pw.TextSpan(
                  text: 'À Payer:   ',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    //font: Gothic,
                  ),
                ),
                if (montant > _grandTotal)
                  pw.TextSpan(
                    text: _aPaye.toString() + '\n',
                    style: pw.TextStyle(
                      color: PdfColors.red,
                    ),
                  ),
                if (montant <= _grandTotal)
                  pw.TextSpan(
                    text: _aPaye.toString() + '\n',
                    style: pw.TextStyle(
                      color: PdfColors.black,
                    ),
                  ),
                pw.TextSpan(
                  text: 'Montant payé:   ',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.TextSpan(
                  text: montant.toString() + '\n',
                  style: pw.TextStyle(
                      //fontFamily: 'Century Gothic',
                      ),
                ),
                pw.TextSpan(
                  text: 'informations spécifiques:   ',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.TextSpan(
                  text: 'TVA Non Applicable Article 293 CGI ',
                  style: pw.TextStyle(
                      //fontFamily: 'Century Gothic',
                      ),
                ),
              ],
            ),
            textAlign: pw.TextAlign.left,
          ),
          decoration: pw.BoxDecoration(
              border: pw.Border(
            bottom: pw.BorderSide(
              color: accentColor,
              width: .5,
            ),
            top: pw.BorderSide(
              color: accentColor,
              width: .5,
            ),
          )),
        )),
      ])
    ]);
  }

  pw.Widget _contentDevisFooter(
      pw.Context context, dynamic font, dynamic font2) {
    if (montant == null) {
      montant = 0;
    }

    if (montant > _grandTotal) {
      _aPaye =
          'Le Montant Que vous encaissez est superieur au montant à payer veuillez vérifier';
    } else {
      _aPaye = _grandTotal - montant;
    }
    return pw.Column(children: [
      pw.Container(
          height: 25,
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
              color: PdfColor.fromInt(0xFF0071E3),
              borderRadius: const pw.BorderRadius.only(
                  bottomLeft: pw.Radius.circular(3),
                  bottomRight: pw.Radius.circular(3))),
          child: pw.Text(_grandTotal.toString(),
              style: pw.TextStyle(
                  color: PdfColor.fromInt(0xFFFFFFFF),
                  fontWeight: pw.FontWeight.bold))),
      pw.SizedBox(height: 30),
      pw.Container(
          alignment: pw.Alignment.centerLeft,
          child: pw.RichText(
            text: pw.TextSpan(
              style: pw.TextStyle(
                fontSize: 12,
                color: PdfColors.black,
              ),
              children: [
                pw.TextSpan(
                  text: 'Soit la somme de : ',
                  style: pw.TextStyle(
                    fontStyle: pw.FontStyle.italic,
                    font: font,
                  ),
                ),
                pw.TextSpan(
                  text: fnumberToLetter(_grandTotal.round()) + ' XAF' + '\n',
                  style: pw.TextStyle(
                    font: font2,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              ],
            ),
            textAlign: pw.TextAlign.left,
          )),
    ]);
  }

  pw.Widget _contentAttestationFooter(
      pw.Context context, dynamic font, dynamic font2,
      {CertificateData data}) {
    return pw.Container(
        alignment: pw.Alignment.center,
        margin: pw.EdgeInsets.only(top: 200),
        child: pw.Column(children: <pw.Widget>[
          pw.Container(
              alignment: pw.Alignment.center,
              child: pw.RichText(
                text: pw.TextSpan(
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                  children: [
                    pw.TextSpan(
                      text:
                          'Je sousigné Jordan Felex NGUE en qualité de formateur en ',
                      style: pw.TextStyle(
                        font: font,
                        fontStyle: pw.FontStyle.italic,
                        color: PdfColor.fromInt(0xFF2E3191),
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.TextSpan(
                      text: '${data?.domain}' + '\n',
                      style: pw.TextStyle(
                          font: font,
                          fontStyle: pw.FontStyle.italic,
                          color: PdfColor.fromInt(0xFF2E3191),
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.TextSpan(
                      text: 'Atteste que, M.Mlle/Mme' + '\n',
                      style: pw.TextStyle(
                          font: font,
                          fontStyle: pw.FontStyle.italic,
                          color: PdfColor.fromInt(0xFF2E3191),
                          fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                textAlign: pw.TextAlign.center,
              )),
          pw.Container(
              margin: pw.EdgeInsets.only(top: 5),
              child: pw.Text("${data?.name} ${data?.lastname}",
                  style: pw.TextStyle(
                    font: font,
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColor.fromInt(0xFF3C3C3B),
                    fontSize: 43,
                    fontWeight: pw.FontWeight.bold,
                  ))),
          pw.Container(
              margin: pw.EdgeInsets.only(top: 40),
              child: pw.Column(children: <pw.Widget>[
                pw.RichText(
                  text: pw.TextSpan(
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.black,
                    ),
                    children: [
                      pw.TextSpan(
                        text: 'a suivi avec succès une formation au sein du ',
                        style: pw.TextStyle(
                          font: font2,
                          fontStyle: pw.FontStyle.italic,
                          color: PdfColor.fromInt(0xFF000000),
                        ),
                      ),
                      pw.TextSpan(
                        text: 'GEG (Global Engineering Group)',
                        style: pw.TextStyle(
                          font: font2,
                          fontStyle: pw.FontStyle.italic,
                          color: PdfColor.fromInt(0xFF2E3191),
                        ),
                      ),
                      pw.TextSpan(
                        text: ' à ',
                        style: pw.TextStyle(
                          font: font2,
                          fontStyle: pw.FontStyle.italic,
                          color: PdfColor.fromInt(0xFF000000),
                        ),
                      ),
                      pw.TextSpan(
                        text: ' ${data?.town} \n',
                        style: pw.TextStyle(
                            font: font,
                            fontStyle: pw.FontStyle.italic,
                            color: PdfColor.fromInt(0xFF000000),
                            fontWeight: pw.FontWeight.bold),
                      ),
                      pw.TextSpan(
                        text: ' du',
                        style: pw.TextStyle(
                          font: font2,
                          fontStyle: pw.FontStyle.italic,
                          color: PdfColor.fromInt(0xFF000000),
                        ),
                      ),
                      pw.TextSpan(
                        text: ' ${data?.startDate}',
                        style: pw.TextStyle(
                            font: font,
                            fontStyle: pw.FontStyle.italic,
                            color: PdfColor.fromInt(0xFF000000),
                            fontWeight: pw.FontWeight.bold),
                      ),
                      pw.TextSpan(
                        text: ' au',
                        style: pw.TextStyle(
                          font: font2,
                          fontStyle: pw.FontStyle.italic,
                          color: PdfColor.fromInt(0xFF000000),
                        ),
                      ),
                      pw.TextSpan(
                        text: ' ${data?.endDate} \n',
                        style: pw.TextStyle(
                            font: font,
                            fontStyle: pw.FontStyle.italic,
                            color: PdfColor.fromInt(0xFF000000),
                            fontWeight: pw.FontWeight.bold),
                      ),
                      pw.TextSpan(
                        text:
                            'Sous partenariat avec Visibility Online Business \n',
                        style: pw.TextStyle(
                            font: font2,
                            fontStyle: pw.FontStyle.italic,
                            color: PdfColor.fromInt(0xFF000000),
                            fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  '\n Cette Attestation est délivrée pour faire valoir ce que de droit',
                  style: pw.TextStyle(
                      font: font,
                      fontStyle: pw.FontStyle.italic,
                      color: PdfColor.fromInt(0xFF2E3191),
                      fontWeight: pw.FontWeight.bold),
                ),
              ]))
        ]));
  }

  pw.Widget _contentTable(
      pw.Context context, dynamic font, dynamic fontRegular) {
    const tableHeaders = ['N°', 'Désignation', 'Qté', 'Prix U.', 'Prix T.'];

    return pw.Padding(
        padding: pw.EdgeInsets.only(top: 20),
        child: pw.Table.fromTextArray(
          border: null,
          cellAlignment: pw.Alignment.centerLeft,
          headerDecoration: pw.BoxDecoration(
            borderRadius: const pw.BorderRadius.only(
                topLeft: pw.Radius.circular(3),
                topRight: pw.Radius.circular(3)),
            color: PdfColor.fromInt(0xFF0071E3),
          ),
          headerHeight: 25,
          cellHeight: 15,
          cellAlignments: {
            0: pw.Alignment.center,
            1: pw.Alignment.center,
            2: pw.Alignment.center,
            3: pw.Alignment.center,
            4: pw.Alignment.center
          },
          headerStyle: pw.TextStyle(
            font: font,
            color: _baseTextColor,
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          ),
          cellStyle: pw.TextStyle(
            font: fontRegular,
            color: _darkColor,
            fontSize: 10,
          ),
          rowDecoration: pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(
                color: accentColor,
                width: .5,
              ),
            ),
          ),
          headers: List<String>.generate(
            tableHeaders.length,
            (col) => tableHeaders[col],
          ),
          data: List<List<String>>.generate(
            products.length,
            (row) => List<String>.generate(
              tableHeaders.length,
              (col) => products[row].getIndex(col),
            ),
          ),
        ));
  }

  pw.Widget _contentDevisTable(
      pw.Context context, dynamic font, dynamic fontRegular) {
    const tableHeaders = ['N°', 'Désignation', 'Qté', 'Prix U.', 'Prix T.'];

    return pw.Padding(
        padding: pw.EdgeInsets.only(top: 20),
        child: pw.Table.fromTextArray(
          border: null,
          cellAlignment: pw.Alignment.centerLeft,
          headerPadding: pw.EdgeInsets.only(right: 20),
          cellPadding: pw.EdgeInsets.only(right: 20),
          headerDecoration: pw.BoxDecoration(
            borderRadius: const pw.BorderRadius.only(
                topLeft: pw.Radius.circular(3),
                topRight: pw.Radius.circular(3)),
            color: PdfColor.fromInt(0xFF0071E3),
          ),
          headerHeight: 25,
          cellHeight: 15,
          cellAlignments: {
            0: pw.Alignment.center,
            1: pw.Alignment.centerLeft,
            2: pw.Alignment.centerLeft,
            3: pw.Alignment.center,
            4: pw.Alignment.centerRight,
          },
          headerStyle: pw.TextStyle(
            font: font,
            color: _baseTextColor,
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          ),
          cellStyle: pw.TextStyle(
            font: fontRegular,
            color: _darkColor,
            fontSize: 10,
          ),
          rowDecoration: pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(
                color: accentColor,
                width: .5,
              ),
            ),
          ),
          headers: List<String>.generate(
            tableHeaders.length,
            (col) => tableHeaders[col],
          ),
          data: List<List<String>>.generate(
            products.length,
            (row) => List<String>.generate(
              tableHeaders.length,
              (col) => products[row].getIndex(col),
            ),
          ),
        ));
  }

  pw.Widget _contentAttestationTable(pw.Context context) {
    return pw.Container();
  }
}

String _formatCurrency(double amount) {
  return '${amount.toStringAsFixed(2)}';
}

class Product {
  const Product(
    this.Num,
    this.designation,
    // this.reduction,
    this.quantity,
    this.price,
  );

  final String Num;
  final String designation;
  // final double reduction;
  final double quantity;
  final double price;
  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return Num;
      case 1:
        return designation;
      case 2:
        return quantity.toString();
      case 3:
        return _formatCurrency(price);
      case 4:
        return _formatCurrency(total);
    }
    return '';
  }
}
