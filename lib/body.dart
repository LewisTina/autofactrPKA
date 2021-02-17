import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:async';

class Body extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body>{
  static var FactOrProfNumber;
  static var jour;
  static var Numero;

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const locale = "fr";
    final dateTimeFormat = DateFormat.yMMMMd(locale);
    var DateDuJour = new DateTime.now();
    String maChaine =  DateFormat('hh yy MM ss').format(DateDuJour);
    jour = 'Saint-Priest le ' + dateTimeFormat.format(DateDuJour);

    Numero =  maChaine.replaceAll(new RegExp(r"\s+\b|\b\s"), "") ;
    const State1 = 'assets/Svg/StatesBars_1.svg';


    return  SingleChildScrollView(
        child: Center(
      child: Column(
          children: <Widget>[
          SvgPicture.asset(
          State1,
          ),


        Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  children: <Widget>[

                    DateOfMounth(),

                    LiteRollingSwitch(
                      value: false,
                      textOn: 'Proforma',
                      textOff: 'Facture',
                      colorOn:  Color.fromRGBO(0, 185, 255, 1),
                      colorOff: Color(0xFF7451eb),
                      iconOn: Icons.edit,
                      iconOff: Icons.print,
                      onChanged: (bool state) {
                        FactOrProfNumber = '${(state) ? 'Proforma N°' : 'Facture N°'} $Numero';
                      },
                    ),


                  ]
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.95,
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              padding: EdgeInsets.only(bottom: 25, left: 15,right: 15,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color(0x17004eff),
              ),

              child: Column(
      children: <Widget>[

              BasicInformations(),

      ]
              ),
            ),
            ),

            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () {Navigator.push(context, InfosCommande());},
              color: Color.fromRGBO(0, 185, 255, 1),
              textColor: Colors.white,
              label: Text('Information Sur Produits',
                style: TextStyle(
                  fontFamily: 'Century Gothic',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),),
              icon: Icon(Icons.assignment),
            ),

            Container(
                width: double.infinity,
                height: 50.0,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 100),
                decoration: BoxDecoration(
                  color: const Color(0x59acacac),
                ),

                  child: Text(
                    'Powered by TinArt © & Designed By Lewis TINA\nL2 Student\'s software Engineering',
                    style: TextStyle(
                      fontFamily: 'Century Gothic',
                      fontSize: 15,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                ),
              ),
          ]

      ),

        )

    );
  }
}


// Creation du block des Dates
class DateOfMounth extends StatelessWidget{

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
            colors: [Color(0xFF7451eb),Color.fromRGBO(0, 185, 255, 1)],
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
          child: Text(formattedDate,
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
class BasicInformations extends StatefulWidget{
  BasicInformations ({Key key}) : super(key: key);

  @override
  _BasicInformations createState() => _BasicInformations();
}

 class _BasicInformations extends State<BasicInformations> {
  var doit = TextEditingController();
  var objet = TextEditingController();
  var adresse = TextEditingController();
  var devoir ='';
  var ob ='';
  var ad = '';
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


  static FractionallySizedBox createView(){
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
                  padding:EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0xffeaeaea),
                  ),

                  child: Row(
                    children: <Widget>[
                      Icon(Icons.assignment_ind, color: Color.fromRGBO(0, 185, 255, 1),),
                      SizedBox(width: 10),
                      Text( globalInstance.devoir,//Body.objet.text,
                        style: TextStyle(
                          fontFamily: 'Century Gothic',
                          color: Color(0x60004eff),
                          fontWeight: FontWeight.w700,
                        ),),
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
  void dispose(){
    globalInstance.devoir = '' ;
    globalInstance.ob = '' ;
    globalInstance.ad = '' ;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              children: <Widget>[
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
              ]
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
        backgroundColor: Color.fromRGBO(232, 239, 255, 1) ,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Informations Sur La Comande' ,
              style: TextStyle(fontFamily: 'Century Gothic',fontWeight: FontWeight.w400,)),
          elevation: 0.0,
          backgroundColor: Color(0xFF7451eb),
        ),

        body: EditionTableau()

    );
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
  List<ElementEntry> entries ;
  List<Product> donnees ;
  static _EditionTableauState globalInstance2 = new _EditionTableauState();

  _Changed(String value) {
    globalInstance2.Montant= value;
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
    return Column(
        children:
        <Widget>[

          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),

                  height: 35,
                  child:TextField(
                    controller: QteController,
                    keyboardType: TextInputType.number,
                    maxLines: 1,

                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 35 / 2,)
                    ),

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,),

                  ) ,
                ),
              ),


              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x170dc8ff),
                  ),
                  height: 35,
                  child:TextField(
                    controller: DesignationController,
                    maxLines: 1,

                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 35 / 2,)
                    ),

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,),

                  ) ,
                ),
              ),


              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 35,
                  child:TextField(
                    controller: PrixUController,
                    maxLines: 1,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 35 / 2,)
                    ),

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,),

                  ) ,
                ),
              ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x170dc8ff),
                  ),
                  height: 35,
                  child:TextField(
                    controller: reductionController,
                    maxLines: 1,
                    onChanged: (String value) {
                      _Changed2(value);
                    },
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 35 / 2,)
                    ),

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,),

                  ) ,
                ),
              ),


            ],
          ),

        ]

    );
  }

  @override
  void dispose(){
    globalInstance2.Montant= '' ;
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

      var Num = (i+1).toString();
      var designation = Designation[i].text;
      if(Designation[i].text.isEmpty){designation = 'Non Mentionner';};

      var reduction = 0.00;

      var quantity = double.tryParse(Qte[i].text);
      if(Qte[i].text.isEmpty){quantity=0;};

      var price = double.tryParse(PrixU[i].text);
      if(PrixU[i].text.isEmpty){price = 0;};

      globalInstance2.donnees.add(Product(Num, designation, reduction,quantity, price));
    }

    if(ligne.length >=1 ) {
      var last = globalInstance2.donnees[ligne.length - 1].quantity;
      if (last == 0) {
        print ('Champ Nom Saisi');
        Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor:  Color(0xffeaeaea),
              elevation: 0,
              duration: Duration(milliseconds: 800),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),

              content: Text('Veuillez Remplir La Ligne Précédente',
                style: TextStyle(
                  fontFamily: 'Century Gothic',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),),
            )
        );
        return ;

      }

    }

    setState(() {});
    ligne.add(createColumn());

  }

  _Done(){
    globalInstance2.donnees = [];
    if(Qte[0].text.isEmpty){
      Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor:  Color(0xffeaeaea),
            elevation: 0,
            duration: Duration(milliseconds: 800),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),

            content: Text('Cette Facture ne contient aucune quantité de produit',
              style: TextStyle(
                fontFamily: 'Century Gothic',
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),),
          ));
      return;
    };

    for (int i = 0; i < ligne.length; i++) {

      var Num = (i+1).toString();
      var designation = Designation[i].text;
      if(Designation[i].text.isEmpty){designation = 'Non Mentionner';};

      var reduction = double.tryParse(Reduction[i].text);
      if(Reduction[i].text.isEmpty){reduction = 0;};

      var quantity = double.tryParse(Qte[i].text);

      var price = double.tryParse(PrixU[i].text);
      if(PrixU[i].text.isEmpty){price = 0;};

      if(Qte[i].text.isNotEmpty){
      globalInstance2.donnees.add(Product(Num, designation,reduction,quantity, price));}
    }

    //if(double.tryParse(globalInstance2.Montant) > Invoice._grandTotal){}


    Navigator.push(context, Printer());
  }


  @override
  Widget build(BuildContext context) {
    const State2 = 'assets/Svg/StatesBars_2.svg';
    //print( _Done.entries );


    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      body: Center(
        child: FractionallySizedBox(
        widthFactor: 0.95,

        child: Column(
        children: <Widget>[
          SvgPicture.asset( State2,),

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
        color: Color(0xFF7451eb),
        shape: CircularNotchedRectangle(),
        child: Container(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 80, ),
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
            textColor:  Color(0xFF7451eb),
            child: Text("Construire",
                style: TextStyle(
                  fontFamily: 'Century Gothic',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
            onPressed: () {_Done();},
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _onDone,
        backgroundColor: Color.fromRGBO(0, 185, 255, 1),
        child: Icon(Icons.add_box),
      ) ,

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

    );
  }
}

class ElementEntry {
  final String qte;
  final String designation;
  final String prixu;
  var  prixt;

  ElementEntry(this.qte, this.designation, this.prixu, this.prixt);
  @override
  String toString() {
        return 'LigneCommande: Quantité= $qte, Désignation= $designation, Prix U= $prixu, Prix T= $prixt';
  }
}
// Creation des En-tete du Tableau Dynamique
class TableHead extends StatelessWidget{
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
                  padding: EdgeInsets.only(top:10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:  Radius.circular(12)),
                    color: Color.fromRGBO(0, 185, 255, 1),
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
                )
            ),

            Expanded(
                flex: 3,
                child: Container(
                  height: 35,
                  padding: EdgeInsets.only(top:10),
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.white),left: BorderSide(color: Colors.white)),
                    color: Color.fromRGBO(0, 185, 255, 1),
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
                )
            ),


            Expanded(
                flex: 2,
                child: Container(
                  height: 35,
                  padding: EdgeInsets.only(top:10),
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.white),left: BorderSide(color: Colors.white)),
                    color: Color.fromRGBO(0, 185, 255, 1),
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
                )
            ),

            Expanded(
                flex: 1,
                child: Container(
                  height: 35,
                  padding: EdgeInsets.only(top:10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight:  Radius.circular(12)),
                    color: Color.fromRGBO(0, 185, 255, 1),
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
                )
            ),


          ],
        ),

      ],
    );
  }
}

class Printer extends MaterialPageRoute<void> {
  Printer()
      : super(builder: (BuildContext context) {

    return Scaffold(


      body: Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          centerTitle: true,
          title:
          Text('Validation',
              style: TextStyle(fontFamily: 'Century Gothic',fontWeight: FontWeight.w400,)
          ),
          backgroundColor: Color(0xFF7451eb),
          elevation: 0.0,
        ),

        body: PdfPreview(build: (format) => generateInvoice(PdfPageFormat.a4),
    ),
    ),);
  });
}

Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {

  final invoice = Invoice(
    invoiceNumber: _BodyState.Numero,
    products: _EditionTableauState.globalInstance2.donnees,
    customerName: 'Abraham Swearegin',
    customerAddress: '54 rue de Rivoli\n75001 Paris, France',
    tax: .15,
    baseColor: PdfColors.teal,
    accentColor: PdfColors.blueGrey900,
  );

  return await invoice.buildPdf(pageFormat);
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

  double get _reduc =>
      products.map<double>((p) => p.reduction).reduce((a, b) => a + b);

  double get _grandTotal => _total - _reduc;

  var montant = double.tryParse(_EditionTableauState.globalInstance2.Montant);

  var  _aPaye;

  //String _logo;

  String _bgShape;
  String _chShape;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = pw.Document();

    final font1 = await rootBundle.load('assets/fonts/roboto1.ttf');
    final font2 = await rootBundle.load('assets/fonts/roboto2.ttf');
    final font3 = await rootBundle.load('assets/fonts/roboto3.ttf');

    _bgShape = await rootBundle.loadString('assets/Svg/FondPKA.svg');
    _chShape = await rootBundle.loadString('assets/Svg/ContHd.svg');

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
          pageTheme: _buildTheme(
            pageFormat,
            pw.Font.ttf(font1),
            pw.Font.ttf(font2),
            pw.Font.ttf(font3),
          ),
          header: _buildHeader,
          footer: _buildFooter,
          build: (context) => [
            _contentHeader(context),
            _contentTable(context),
            pw.SizedBox(height: 20),
            _contentFooter(context),
            pw.SizedBox(height: 20),
          ]
      ),
    );

    // Return the PDF file content
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(await doc.save());
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Stack(
        children: <pw.Widget>[
          pw.Column(
            children: [
              pw.Row(
                  children: [
                    pw.Container(
                      height: 129,
                    )
                  ]
              ),
              pw.SizedBox(height: 40)
            ],
          ),
          pw.Positioned(
            top: 130,
            left: 390.31,
            child:pw.Text(
              Num,
              style: pw.TextStyle(
                fontSize: 13.5,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromInt(0xFF00A6F0),
              ),
            ),
          ),

        ]);
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          height: 50,
          width: 100,
          child: pw.BarcodeWidget(
            barcode: pw.Barcode.qrCode(),
            data: 'Invoice# $invoiceNumber',
          ),
        ),
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.black,
          ),
        ),
      ],
    );
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat,pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      margin: pw.EdgeInsets.only(left:20,right: 20, bottom: 55) ,
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

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Stack(
      children: <pw.Widget>[
        pw.SvgImage(svg: _chShape),
        pw.Container(
          margin: pw.EdgeInsets.only(top: 60, left: 30),
          width: 500,
          child: pw.RichText(
            text: pw.TextSpan(
              style: pw.TextStyle(
                fontSize: 12,
                color: PdfColors.black,
              ),
              children: [
                pw.TextSpan(
                  text: 'Nom:   ',
                  style:  pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                    //font: Gothic,
                  ),
                ),
                pw.TextSpan(
                  text: _BasicInformations.globalInstance.devoir +'\n',
                  style:  pw.TextStyle(
                    //fontFamily: 'Century Gothic',
                  ),
                ),
                pw.TextSpan(
                  text: 'Adresse:   ',
                  style:  pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
                pw.TextSpan(
                  text: _BasicInformations.globalInstance.ad,
                  style:  pw.TextStyle(
                    //fontFamily: 'Century Gothic',
                  ),
                ),
              ],
            ),
            textAlign:  pw.TextAlign.left,
          ),
        ),

        pw.Container(
          margin: pw.EdgeInsets.only(top: 145, left: 30),
          width: 500,
          child: pw.RichText(
            text: pw.TextSpan(
              text: _BasicInformations.globalInstance.ob,
              style:  pw.TextStyle(
                fontStyle: pw.FontStyle.italic,
              ),
            ),
            textAlign:  pw.TextAlign.left,
          ),
        ),

        pw.Container(
          margin: pw.EdgeInsets.only(left: 390, right: 20),
            child: pw.RichText(
              text: pw.TextSpan(
                text: _BodyState.jour,
                style: pw.TextStyle(
                    fontSize: 11,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
              textAlign:  pw.TextAlign.left,
            ),
        )

      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    if(montant == null){ montant = 0;}

    if( montant > _grandTotal){
     _aPaye = 'Le Montant Que vous encaissez est superieur au montant à payer veuillez vérifier';
    }

    else{
      _aPaye = _grandTotal - montant;
    }
    return pw.Column(
      children: [
    pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
        ),
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
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Réduction:'),
                    pw.Text('$_reduc'),
                  ],
                ),
                pw.Divider(color: accentColor),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: PdfColor.fromInt(0xFF00A6F0),
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
        pw.Row(
          children: [
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
                          style:  pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            //font: Gothic,
                          ),
                        ),
                        if( montant > _grandTotal)
                        pw.TextSpan(
                          text: _aPaye.toString() + '\n',
                          style:  pw.TextStyle(
                            color: PdfColors.red,
                          ),
                        ),

                        if( montant <= _grandTotal)
                          pw.TextSpan(
                            text: _aPaye.toString() + '\n',
                            style:  pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          ),

                        pw.TextSpan(
                          text: 'Montant payé:   ',
                          style:  pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.TextSpan(
                          text: montant.toString() +'\n',
                          style:  pw.TextStyle(
                            //fontFamily: 'Century Gothic',
                          ),
                        ),
                      pw.TextSpan(
                          text: 'informations spécifiques:   ',
                          style:  pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.TextSpan(
                          text: 'TVA Non Applicable Article 293 CGI ',
                          style:  pw.TextStyle(
                            //fontFamily: 'Century Gothic',
                          ),
                        ),
                      ],
                    ),
                    textAlign:  pw.TextAlign.left,
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
                )
            ),

                )
            ),
          ]
        )
      ]
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'N°',
      'Désignation',
      'Réduction',
      'Qté',
      'Prix U.',
      'Prix T.'
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: PdfColor.fromInt(0xFF00A6F0),
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
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
    );
  }
}

String _formatCurrency(double amount) {
  return '\€${amount.toStringAsFixed(2)}';
}

class Product {
  const Product(
      this.Num,
      this.designation,
      this.reduction,
      this.quantity,
      this.price,
      );

  final String Num;
  final String designation;
  final double reduction;
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
        return reduction.toString();
      case 3:
        return quantity.toString();
      case 4:
        return _formatCurrency(price);
      case 5:
        return _formatCurrency(total);
    }
    return '';
  }
}