import 'package:autofact/features/printer/models/certificateData.dart';
import 'package:autofact/features/printer/presentation/widgets/printer.dart';
import 'package:flutter/material.dart';

class CertificateForm extends StatefulWidget {
  const CertificateForm({Key key}) : super(key: key);

  @override
  _CertificateFormState createState() => _CertificateFormState();
}

class _CertificateFormState extends State<CertificateForm> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController town = TextEditingController();
  TextEditingController domain = TextEditingController();
  String startDate = "__/__/__";
  String endDate = "__/__/__";

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context, bool isStart) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
    isStart == true
        ? startDate =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
        : endDate =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Attestation',
            style: TextStyle(
              fontFamily: 'Century Gothic',
              fontWeight: FontWeight.w400,
            )),
        backgroundColor: Color(0xFF2E3191),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextFormField(
              controller: lastname,
              onChanged: (String value) {},
              decoration: InputDecoration(
                labelText: 'Nom',
                prefixIcon: Icon(Icons.assignment_ind),
              ),
            ),
            TextFormField(
              controller: firstname,
              onChanged: (String value) {},
              decoration: InputDecoration(
                labelText: 'Prénom',
                prefixIcon: Icon(Icons.assignment_ind),
              ),
            ),
            TextFormField(
              controller: town,
              onChanged: (String value) {},
              decoration: InputDecoration(
                labelText: 'Ville',
                prefixIcon: Icon(Icons.location_city_rounded),
              ),
            ),
            TextFormField(
              controller: domain,
              onChanged: (String value) {},
              decoration: InputDecoration(
                labelText: 'Domaine',
                prefixIcon: Icon(Icons.location_city_rounded),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Row(
              children: [
                TextButton(
                  child: Row(
                    children: [Text("Date de début : ")],
                  ),
                  onPressed: () {
                    _selectDate(context, true);
                  },
                ),
                SizedBox(
                  width: 15,
                ),
                Text(startDate,
                    style: TextStyle(
                        fontFamily: 'Century Gothic',
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))
              ],
            ),
            Row(
              children: [
                TextButton(
                  style: ButtonStyle(),
                  child: Row(
                    children: [Text("Date de fin : ")],
                  ),
                  onPressed: () {
                    _selectDate(context, false);
                  },
                ),
                SizedBox(
                  width: 15,
                ),
                Text(endDate,
                    style: TextStyle(
                        fontFamily: 'Century Gothic',
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () {
                if (lastname.value != null &&
                    firstname.value != null &&
                    town.value != null &&
                    domain.value != null &&
                    startDate != '' &&
                    endDate != '') {
                  print(lastname.value.text.toString());
                  CertificateData data = new CertificateData(
                      name: lastname.value.text.toString(),
                      lastname: firstname.value.text.toString(),
                      town: town.value.text.toString(),
                      startDate: startDate,
                      endDate: endDate,
                      domain: domain.value.text.toString());
                  print("the data : ${data.name}");
                  Navigator.push(context, Printer(formatModel: 3, data: data));
                }
              },
              color: Color(0xFF0071E3),
              textColor: Colors.white,
              label: Text(
                "Générer",
                style: TextStyle(
                  fontFamily: 'Century Gothic',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              icon: Icon(Icons.assignment),
            )
          ]),
        ),
      ),
    );
  }
}
