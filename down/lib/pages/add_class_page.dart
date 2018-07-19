import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class AddClassPage extends StatelessWidget {

  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _instructorController = new TextEditingController();
  final TextEditingController _locationController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();
  final TextEditingController _dateController = new TextEditingController();
  final TextEditingController _timeController = new TextEditingController();

  Widget appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: Colors.black,
        icon: Icon(
          Icons.chevron_left
       ),
       onPressed: () {
         Navigator.pop(context);
       },
      ),
      centerTitle: true,
      backgroundColor: Color(0xffFF9391),
      elevation: 1.0,
      title: Text(
        'Add Class',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("\nBUILDING ADD CLASS PAGE\n");
    DateTime _date = new DateTime.now();
    TimeOfDay _time = new TimeOfDay.now();

    Future<Null> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2022),
      );

      if (picked != null) {
        _date = picked;
        String date = new DateFormat("yMd").format(_date).toString();
        _dateController.text = date.replaceAll('20', '');
      }
    }

    Future<Null> _selectTime(BuildContext context) async {
      final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time,
      );

      if (picked != null) {
        _time = picked;
        String minute = _time.minute == 0 ? '00' : _time.minute.toString();
        String period = _time.hour > 12 ? 'PM' : 'AM';
        _timeController.text = '${_time.hourOfPeriod.toString()}:$minute $period';
      }
    }

    final FocusNode _instructorFocusNode = new FocusNode();
    final FocusNode _locationFocusNode = new FocusNode();
    final FocusNode _priceFocusNode = new FocusNode();

    return Scaffold(
      appBar: appBar(context),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            PrimaryColorOverride(
              color: downSalmon,
              child: TextFormField(
                controller: _titleController,
                autofocus: true,
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_instructorFocusNode);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  labelText: 'Class Title',
                ),
              ),
            ),

            SizedBox(height: 16.0),

            PrimaryColorOverride(
              color: downSalmon,
              child: TextFormField(
                controller: _instructorController,
                focusNode: _instructorFocusNode,
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_locationFocusNode);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  labelText: 'Instructor',
                ),
              ),
            ),

            SizedBox(height: 16.0),

            PrimaryColorOverride(
              color: downSalmon,
              child: TextFormField(
                controller: _locationController,
                focusNode: _locationFocusNode,
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  labelText: 'Location',
                ),
              ),
            ),

            SizedBox(height: 16.0),

            Row(
              children: <Widget>[
                Flexible(
                  child: PrimaryColorOverride(
                    color: downSalmon,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _priceController,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (String value) {
                        _selectDate(context);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                        labelText: 'Price',
                        prefixText: '\$',
                      ),
                    ),
                  ),
                ),

                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDate(context);
                    _selectTime(context);
                  },
                ),

                Flexible(
                  child: PrimaryColorOverride(
                    color: downSalmon,
                    child: TextFormField(
                      enabled: false,
                      controller: _dateController,
                      decoration: InputDecoration(
                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                         labelText: 'Date',
                      ),
                    ),
                  ),
                ),

                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.access_time),
                  onPressed: () {
                    _selectTime(context);
                  },
                ),

                Flexible(
                  child: PrimaryColorOverride(
                    color: downSalmon,
                    child: TextFormField(
                      enabled: false,
                      controller: _timeController,
                      decoration: InputDecoration(
                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                         labelText: 'Time',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonTheme(
                minWidth: double.infinity,
                height: 64.0,
                child: RaisedButton(
                  // borderSide: BorderSide(color: Colors.black, width: 5.0),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                  onPressed: () {
                    Map<String, Object> org = new Map<String, Object>();

                    String title = _titleController.text;
                    String instructor = _instructorController.text;
                    String location = _locationController.text;
                    int price = int.parse(_priceController.text);
                    String date = _dateController.text;
                    String time = _timeController.text;
                    String documentID = title.toLowerCase().replaceAll(' ', '')
                    + instructor.toLowerCase().replaceAll(' ', '')
                    + location.toLowerCase().replaceAll(' ', '')
                    + price.toString();

                    org = {'title' : title, 
                    'instructor' : instructor,
                    'location' : location, 
                    'price' : price,
                    'date' : date,
                    'time' : time
                    };

                    Firestore.instance.collection('classes').document(documentID).setData(org,);

                    _titleController.clear();
                    _instructorController.clear();
                    _locationController.clear();
                    _priceController.clear();
                    _dateController.clear();
                    _timeController.clear();

                    Navigator.pop(context);
                  },
                ),
              ),
      ),
    );
  }
}

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
       data: Theme.of(context).copyWith(primaryColor: color),
    );
  }
}