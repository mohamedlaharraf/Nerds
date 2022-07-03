import 'package:nerds/app_style.dart';
import 'package:nerds/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      appBar: AppBar(
        title: const Text('Data Interpretation'),
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date du traitement",
                style: AppStyle.mainTitle,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                widget.doc['date_save'],
                style: AppStyle.mainContent,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Doctor: " + widget.doc['prenom'],
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Données du patient",
                style: AppStyle.mainTitle,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Patient: " + widget.doc['nom'],
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Age: " + widget.doc['age'].toStringAsFixed(0).toString(),
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Sexe: " + widget.doc['sexe'].toString(),
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Diametre: " +
                    widget.doc['diametre'].toStringAsFixed(3).toString() +
                    " mm",
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Surface: " +
                    widget.doc['surface'].toStringAsFixed(3).toString() +
                    " mm²",
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Vmax: " +
                    widget.doc['Vmax'].toStringAsFixed(3).toString() +
                    " m/s",
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "IP: " + widget.doc['IP'].toStringAsFixed(3).toString() + " ",
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Interpretations",
                style: AppStyle.mainTitle,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Interpretation: " + widget.doc['interpretation'].toString(),
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Commentaires: " + widget.doc['doctor_comment'].toString(),
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => reportFile(
                date_save: widget.doc['date_save'],
                patient_name: "Patient: " + widget.doc['nom'],
                doctor_name: "Doctor: " + widget.doc['prenom'],
                age: "Age: " + widget.doc['age'].toStringAsFixed(0).toString(),
                sexe: "Sexe: " + widget.doc['sexe'].toString(),
                Diametre: "Diametre: " +
                    widget.doc['diametre'].toStringAsFixed(3).toString() +
                    " mm",
                Surface: "Surface: " +
                    widget.doc['surface'].toStringAsFixed(3).toString() +
                    " mm²",
                Vmax: "Vmax: " +
                    widget.doc['Vmax'].toStringAsFixed(3).toString() +
                    " m/s",
                IP: "IP: " +
                    widget.doc['IP'].toStringAsFixed(3).toString() +
                    " ",
                Interpretation: "Interpretation: " +
                    widget.doc['interpretation'].toString(),
                Commentaires:
                    "Commentaires: " + widget.doc['doctor_comment'].toString(),
              ),
            ),
          );
        },
        child: const Icon(Icons.file_download),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
