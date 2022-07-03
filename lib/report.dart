// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class reportFile extends StatefulWidget {
  String date_save;
  String patient_name;
  String doctor_name;
  String age;
  String sexe;
  String Diametre;
  String Surface;
  String Vmax;
  String IP;
  String Interpretation;
  String Commentaires;

  reportFile({
    required this.date_save,
    required this.patient_name,
    required this.doctor_name,
    required this.age,
    required this.sexe,
    required this.Diametre,
    required this.Surface,
    required this.Vmax,
    required this.IP,
    required this.Interpretation,
    required this.Commentaires,
  });
  @override
  State<reportFile> createState() => _reportFileState(
        date_save: date_save,
        patient_name: patient_name,
        doctor_name: doctor_name,
        age: age,
        sexe: sexe,
        Diametre: Diametre,
        Surface: Surface,
        Vmax: Vmax,
        IP: IP,
        Interpretation: Interpretation,
        Commentaires: Commentaires,
      );
}

class _reportFileState extends State<reportFile> {
  String date_save;
  String patient_name;
  String doctor_name;
  String age;
  String sexe;
  String Diametre;
  String Surface;
  String Vmax;
  String IP;
  String Interpretation;
  String Commentaires;

  _reportFileState(
      {required this.date_save,
      required this.patient_name,
      required this.doctor_name,
      required this.age,
      required this.sexe,
      required this.Diametre,
      required this.Surface,
      required this.Vmax,
      required this.IP,
      required this.Interpretation,
      required this.Commentaires});
  final pdf = pw.Document();

  void initState() {
    setState(() {
      date_save = date_save;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      // maxPageWidth: 1000,
      // useActions: false,
      // canChangePageFormat: true,
      canChangeOrientation: false,
      // pageFormats:pageformat,
      canDebug: false,

      build: (format) => generateDocument(
        format,
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();

    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            marginBottom: 0,
            marginLeft: 0,
            marginRight: 0,
            marginTop: 0,
          ),
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (context) {
          return pw.Container(
              child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'Rapport autodiam',
                  style: pw.TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    "Date du traitement: ",
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    date_save,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    doctor_name,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    patient_name,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    age,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    sexe,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    Diametre,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    Surface,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    Interpretation,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    Commentaires,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );

    return doc.save();
  }
}
