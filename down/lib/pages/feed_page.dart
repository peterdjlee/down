import 'package:down/bottom_bar.dart';
import 'package:down/pages/class_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedPage extends StatelessWidget {

  final topBar = AppBar(
    centerTitle: true,
    backgroundColor: Color(0xffFF9391),
    elevation: 1.0,
    title: Text(
        'Down',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        )
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar,
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: <Widget>[
          ClassCard('exampleclass')
          ],
      ),
      bottomNavigationBar: BottomBar(page: 'FeedPage'),
    );
  }
}