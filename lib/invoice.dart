import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generateInvoice(PdfPageFormat pageFormat) async {
  final lorem = pw.LoremText();

  final products = <Product>[
    Product('1', lorem.sentence(4), '', 0, 3.99, 2),
  ];

  final invoice = Invoice(
    invoiceNumber: '982347',
    products: products,
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

  PdfColor get _baseTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  double get _total =>
      products.map<double>((p) => p.total).reduce((a, b) => a + b);

  double get _grandTotal => _total * (1 + tax);

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
              ]),
    );

    // Return the PDF file content
    final file = File("example.pdf");
    await file.writeAsBytes(await doc.save());
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Stack(children: <pw.Widget>[
      pw.Column(
        children: [
          pw.Row(children: [
            pw.Container(
              height: 129,
            )
          ]),
          pw.SizedBox(height: 40)
        ],
      ),
      pw.Positioned(
        top: 130,
        left: 418.31,
        child: pw.Text(
          'Facture 0001',
          style: pw.TextStyle(
            fontSize: 17,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromInt(0xFF0071E3),
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
          height: 20,
          width: 100,
          child: pw.BarcodeWidget(
            barcode: pw.Barcode.pdf417(),
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
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      margin: pw.EdgeInsets.only(left: 20, right: 20, bottom: 55),
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
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                    //font: Gothic,
                  ),
                ),
                pw.TextSpan(
                  text: 'M. Mme Chalot\n',
                  style: pw.TextStyle(
                      //fontFamily: 'Century Gothic',
                      ),
                ),
                pw.TextSpan(
                  text: 'Adresse:   ',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
                pw.TextSpan(
                  text: '263 c impasse du dois saint paul 69390 Charly',
                  style: pw.TextStyle(
                      //fontFamily: 'Century Gothic',
                      ),
                ),
              ],
            ),
            textAlign: pw.TextAlign.left,
          ),
        ),
        pw.Container(
          margin: pw.EdgeInsets.only(top: 145, left: 30),
          width: 500,
          child: pw.RichText(
            text: pw.TextSpan(
              text: 'Pose de carrelage salon, cuisine, séjour et hall',
              style: pw.TextStyle(
                fontStyle: pw.FontStyle.italic,
              ),
            ),
            textAlign: pw.TextAlign.left,
          ),
        )
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
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
                    pw.Text('Sub Total:'),
                    pw.Text(_formatCurrency(_total)),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Tax:'),
                    pw.Text('${(tax * 100).toStringAsFixed(1)}%'),
                  ],
                ),
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
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'N°',
      'Désignation',
      'Référence',
      'Réduction',
      'Qté',
      'Prix U.',
      'Prix T.'
    ];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
        color: PdfColor.fromInt(0xFF0071E3),
      ),
      headerHeight: 25,
      cellHeight: 15,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
        5: pw.Alignment.centerRight,
        6: pw.Alignment.centerRight,
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
  return '\${amount.toStringAsFixed(2)}';
}

class Product {
  const Product(
    this.Num,
    this.designation,
    this.reference,
    this.reduction,
    this.price,
    this.quantity,
  );

  final String Num;
  final String designation;
  final String reference;
  final double reduction;
  final double price;
  final int quantity;
  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return Num;
      case 1:
        return designation;
      case 2:
        return reference;
      case 3:
        return reduction.toString();
      case 4:
        return _formatCurrency(price);
      case 5:
        return quantity.toString();
      case 6:
        return _formatCurrency(total);
    }
    return '';
  }
}
