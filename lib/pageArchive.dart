import 'package:nerds/app_style.dart';
import 'package:nerds/note_card.dart';
import 'package:nerds/note_reader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PageArchive extends StatefulWidget {
  const PageArchive({Key? key}) : super(key: key);

  @override
  _PageArchiveState createState() => _PageArchiveState();
}

class _PageArchiveState extends State<PageArchive> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('AutodiamData')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    children: snapshot.data!.docs
                        .map((dataPatient) => noteCard(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NoteReaderScreen(dataPatient)));
                            }, dataPatient))
                        .toList(),
                  );
                }
                return Text(
                  'There is no Data',
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GoogleFonts {}
