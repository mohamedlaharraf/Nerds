
import 'package:nerds/app_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  _InsertDataState createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  File? selectedImage;
  String? message = "not uploaded yet";
  double diametre = 0;
  double surface = 0;

  uploadImage() async {
    final request = http.MultipartRequest(
        "POST", Uri.parse("https://gbmapi.herokuapp.com/upload"));
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile("image",
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));

    request.headers.addAll(headers);
    final response = await request.send();

    http.Response res = await http.Response.fromStream(response);

    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    diametre = double.tryParse(message!)!;
    diametre = diametre * 0.34;
    surface =
        diametre * diametre * double.tryParse(_ipController.text)! * 3.14 / 4;

    setState(() {});
  }

  Future getImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    selectedImage = File(pickedImage!.path);
    setState(() {});
  }

  // ------------- for Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ---------------

  String date = DateTime.now().toString();
  String interpretation = 'Pas d interpretation';
  // diametre
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _vmaxController = TextEditingController();
  TextEditingController _ipController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  String _sexe = 'Homme';

  var items = [
    'Homme',
    'Femme',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert DATA'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: AppStyle.dateTitle,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom patient',
                  border: OutlineInputBorder(),
                ),
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _prenomController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nom doctor',
                ),
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age patient',
                ),
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _vmaxController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'V max (m/s)',
                ),
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _ipController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'IP',
                ),
                style: AppStyle.mainContent,
              ),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                // Initial Value
                value: _sexe,
                // Down Arrow Icon
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.blueAccent,
                ),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    _sexe = newValue!;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: getImage,
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.blueAccent,
                      ),
                      label: Text(
                        "Upload Radio ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    selectedImage == null
                        ? Text("( Please pick image to upload )")
                        : Image.file(
                            selectedImage!,
                            height: 50,
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _commentController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Commentaire',
                ),
                style: AppStyle.mainContent,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (selectedImage != null) {
            await uploadImage();

            if (double.tryParse(_vmaxController.text)! >= 4) {
              interpretation = "RAC SEVERE";
            } else {
              if (surface >= 200) {
                interpretation = "PAS DE RAC LACHE";
              } else if ((surface < 200) & (surface > 150)) {
                interpretation = "PAS DE RAC LACHE";
              } else if ((surface <= 150) & (surface > 100)) {
                interpretation = "RAC MODERE";
              } else {
                interpretation = "RAC SEVERE";
              }
            }

            FirebaseFirestore.instance.collection('AutodiamData').add({
              'IP': double.tryParse(_ipController.text)!,
              'Vmax': double.tryParse(_vmaxController.text)!,
              'age': double.tryParse(_ageController.text)!,
              'date_save': date,
              'diametre': diametre,
              'doctor_comment': _commentController.text,
              'interpretation': interpretation,
              'nom': _nomController.text,
              'prenom': _prenomController.text,
              'sexe': _sexe,
              'surface': surface,
            }).then((value) {
              print(value.id);
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdvanceCustomAlert();
                  });
            }).catchError(
                (error) => print('Failed to add new data due to $error'));
          }
        },
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

class AdvanceCustomAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      'Done',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Vous pouvez consulter les resultats dans les archives',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.blueAccent,
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 60,
                  child: Icon(
                    Icons.archive_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                )),
          ],
        ));
  }
}
