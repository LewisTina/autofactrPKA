import 'package:autofact/features/printer/models/certificateData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../../../body.dart';

class Printer extends MaterialPageRoute<void> {
  Printer({@required int formatModel, CertificateData data})
      : super(builder: (BuildContext context) {
          String fileName = "";
          String currentStringDate =
              DateFormat('hh yy MM ss').format(new DateTime.now());
          switch (formatModel) {
            case 1:
              {
                fileName = "FACTURE N° " + currentStringDate;
              }
              break;
            case 2:
              {
                fileName = "DEVIS N° " + currentStringDate;
              }
              break;
            case 3:
              {
                fileName = "ATTESTATION " + data.name + data.lastname;
              }
              break;
          }
          return Scaffold(
            body: Scaffold(
              backgroundColor: const Color(0xffffffff),
              appBar: AppBar(
                centerTitle: true,
                title: Text('Validation',
                    style: TextStyle(
                      fontFamily: 'Century Gothic',
                      fontWeight: FontWeight.w400,
                    )),
                backgroundColor: Color(0xFF2E3191),
                elevation: 0.0,
              ),
              body: PdfPreview(
                build: (format) =>
                    generateInvoice(PdfPageFormat.a4, formatModel, data: data),
                pdfFileName: fileName,
              ),
            ),
          );
        });
}
