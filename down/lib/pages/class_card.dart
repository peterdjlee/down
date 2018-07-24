import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ClassCard extends StatelessWidget {
  final String classID;
  Future<QuerySnapshot> querySnapshot;

  ClassCard(this.classID) {
    // CollectionReference classesRef = Firestore.instance.collection('classes');
    // classesRef.where('id', isEqualTo: classID)
    // .snapshots().listen(
    //   (date) => print('name ${classesRef.documents[0]['id']}')
    // );
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('classes').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        final int classCount = snapshot.data.documents.length;
        return new ListView.builder(
          itemCount: classCount,
          itemBuilder: (_, int index) {
            final DocumentSnapshot document = snapshot.data.documents[index];
              return new ListTile(
                title: new Text(document['title']),
                subtitle: new Text(document['instructor']),
              );
            // return new Card(
            //   child: Column(
            //     children: <Widget>[
            //       Padding(
            //         padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             Text(
            //               document['tite'],
            //               style: TextStyle(
            //                 fontSize: 30.0
            //               ),
            //             ),
              //           SizedBox(height: 8.0),
              //           Text(document['instructor']),
              //         ],
              //       ),
              //     )
              //   ]
            //   ),
            // );
          },
        );
      },
    );
  }
}