import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassPage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  ClassPage({this.documentSnapshot});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffFF9391),
        elevation: 1.0,
        title: Text(
          documentSnapshot['title'],
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          )
        ),
      ),
      body: Container(
        child: Center(
          child: Text(
            'ClassPage'
          )
        ),
      ),
    );
  }
}