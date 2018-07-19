import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down/bottom_bar.dart';
import 'package:flutter/material.dart';

class AddOrgPage extends StatelessWidget {

  final topBar = AppBar(
    centerTitle: true,
    backgroundColor: Color(0xfff8faf8),
    elevation: 1.0,
    title: Text(
        'Add Class',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25.0,
        )
    ),
  );

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _locationController = new TextEditingController();
    TextEditingController _sizeController = new TextEditingController();

    return Scaffold(
      appBar: topBar,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                labelText: 'Class Title',
              ),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _sizeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                labelText: 'Instructor',
              ),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _sizeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                labelText: 'Date',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                labelText: 'Location',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _sizeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                labelText: 'Price',
              ),
            ),
            SizedBox(height: 12.0),
            RaisedButton(
              color: Colors.black,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
              child: Text(
                'SUBMIT',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onPressed: () {
                Map<String, Object> org = new Map<String, Object>();

                String name = _nameController.text;
                String documentID = name.toLowerCase().replaceAll(' ', '');
                print(documentID);
                String location = _locationController.text;
                int size = int.parse(_sizeController.text);

                org = {'name' : '$name', 'locations' : '$location', 'size' : '$size'};
                Firestore.instance.collection('organizations').document(documentID).setData(org,);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}