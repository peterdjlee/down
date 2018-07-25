import 'dart:async';

import 'package:down/class_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ClassList extends StatelessWidget {
  final String classID;
  Future<QuerySnapshot> querySnapshot;

  ClassList(this.classID) {
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
            return ClassCard(
              documentSnapshot: document
            );
          },
        );
      },
    );
  }
}