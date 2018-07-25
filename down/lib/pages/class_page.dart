import 'package:down/bottom_bar.dart';
import 'package:flutter/material.dart';

class ClassPage extends StatelessWidget {

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