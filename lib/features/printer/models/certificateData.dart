import 'package:flutter/cupertino.dart';

class CertificateData {
  final String name, lastname, town, startDate, endDate, domain;
  CertificateData(
      {@required this.name,
      @required this.lastname,
      @required this.town,
      @required this.startDate,
      @required this.endDate,
      @required this.domain});
  CertificateData copyWith({String name, lastname, town, startDate, endDate, domain}) =>
      CertificateData(
          name: name ?? this.name,
          town: town ?? this.town,
          startDate: startDate ?? this.startDate,
          endDate: endDate ?? this.endDate,
          lastname: lastname ?? this.lastname,
        domain: domain ?? this.domain
      );
}
