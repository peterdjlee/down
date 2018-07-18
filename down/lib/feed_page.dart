import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedPage extends StatelessWidget {

  final topBar = AppBar(
    centerTitle: true,
    backgroundColor: Color(0xfff8faf8),
    elevation: 1.0,
    title: Text(
        'Down',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25.0,
        )
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar,
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('organizations').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.all(20.0),
                itemExtent: 50.0,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
              
                  Map<String, Object> org = new Map<String, Object>();
                  org = {'name' : 'Project D', 'location' : 'New Jersey'};

                  Firestore.instance.collection('organizations/projectd').add(org);

                  return new Text(" ${ds['name']} has ${ds['size']} people and is located in ${ds['locations']}");
                }
            );
          }
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        height: 50.0,
        alignment: Alignment.center,
        child: new BottomAppBar(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new IconButton(
                  icon: Icon(
                    Icons.home,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print('FeedPage');
                  },
              ),
              new IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30.0,
                ),
                onPressed: () {
                  print('SearchPage');
                },
              ),
              new IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 30.0,
                ),
                onPressed: () {
                  print('AddPage');
                },
              ),
              new IconButton(
                icon: Icon(
                  Icons.people_outline,
                  size: 30.0,
                ),
                onPressed: () {
                  print('OrganizationPage');
                },
              ),
              new IconButton(
                icon: Icon(
                  Icons.person_outline,
                  size: 30.0,
                ),
                onPressed: () {
                  print('InstructorPage');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}