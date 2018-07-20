import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class AddClassPage extends StatelessWidget {

  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _instructorController = new TextEditingController();
  final TextEditingController _locationController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();
  final TextEditingController _dateController = new TextEditingController();
  final TextEditingController _startTimeController = new TextEditingController();
  final TextEditingController _endTimeController = new TextEditingController();

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

    Future<Null> _selectStartTime(BuildContext context) async {
      final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time,
      );

      if (picked != null) {
        _time = picked;
        String minute;
        if (_time.minute < 10) {
          minute = '0${_time.minute}';
        } else {
          minute = _time.minute.toString();
        }

        String period = _time.hour > 12 ? 'PM' : 'AM';
        _startTimeController.text = '${_time.hourOfPeriod.toString()}:$minute $period';
      }
    }

    Future<Null> _selectEndTime(BuildContext context) async {
      final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time,
      );

      if (picked != null) {
        _time = picked;
        String minute;
        if (_time.minute < 10) {
          minute = '0${_time.minute}';
        } else {
          minute = _time.minute.toString();
        }

        String period = _time.hour > 12 ? 'PM' : 'AM';
        _endTimeController.text = '${_time.hourOfPeriod.toString()}:$minute $period';
      }
    }

    final FocusNode _instructorFocusNode = new FocusNode();
    final FocusNode _locationFocusNode = new FocusNode();
    final FocusNode _priceFocusNode = new FocusNode();
    final FocusNode _dateFocusNode = new FocusNode();
    final FocusNode _startTimeFocusNode = new FocusNode();
    final FocusNode _endTimeFocusNode = new FocusNode();

    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: appBar(context),
      body: ListView(
        shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PrimaryColorOverride(
                color: downSalmon,
                child: TextFormField(
                  controller: _titleController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  onFieldSubmitted: (String value) {
                    FocusScope.of(context).requestFocus(_instructorFocusNode);
                  },
                  decoration: InputDecoration(
                    // suffixIcon: IconButton(
                    //   iconSize: 20.0,
                    //   icon: Icon(FontAwesomeIcons.timesCircle),
                    //   color: Colors.black26,
                    //   onPressed: () {
                    //     _titleController.clear();
                    //   },
                    // ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Class Title',
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: PrimaryColorOverride(
                color: downSalmon,
                child: TextFormField(
                  controller: _instructorController,
                  focusNode: _instructorFocusNode,
                  onFieldSubmitted: (String value) {
                    FocusScope.of(context).requestFocus(_locationFocusNode);
                  },
                  decoration: InputDecoration(
                    // suffixIcon: IconButton(
                    //   iconSize: 20.0,
                    //   icon: Icon(FontAwesomeIcons.timesCircle),
                    //   color: Colors.black26,
                    //   onPressed: () {
                    //     _instructorController.clear();
                    //   },
                    // ),
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.black,
                      ),
                    labelText: 'Instructor',
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, right:16.0, top: 8.0, bottom: 8.0),
              child: PrimaryColorOverride(
                color: downSalmon,
                child: TextFormField(
                  controller: _locationController,
                  focusNode: _locationFocusNode,
                  onFieldSubmitted: (String value) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  decoration: InputDecoration(
                    // suffixIcon: IconButton(
                    //   iconSize: 20.0,
                    //   icon: Icon(FontAwesomeIcons.timesCircle),
                    //   color: Colors.black26,
                    //   onPressed: () {
                    //     _locationController.clear();
                    //   },
                    // ),
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.black,
                      ),
                    labelText: 'Location',
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, right:16.0, top: 8.0, bottom: 8.0),
              child: PrimaryColorOverride(
                  color: downSalmon,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _priceController,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_dateFocusNode);
                    },
                    decoration: InputDecoration(
                      // suffixIcon: IconButton(
                      //   iconSize: 20.0,
                      //   icon: Icon(FontAwesomeIcons.timesCircle),
                      //   color: Colors.black26,
                      //   onPressed: () {
                      //     _priceController.clear();
                      //   },
                      // ),
                      icon: Icon(
                        Icons.monetization_on,
                        color: Colors.black,
                      ),
                      labelText: 'Price',
                      prefixText: '\$',
                    ),
                  ),
                ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, right:16.0, top: 8.0, bottom: 8.0),
              child: PrimaryColorOverride(
                color: downSalmon,
                child: TextFormField(
                  controller: _dateController,
                  focusNode: _dateFocusNode,
                  onFieldSubmitted: (String value) {
                    FocusScope.of(context).requestFocus(_startTimeFocusNode);
                  },
                  decoration: InputDecoration(
                    helperStyle: TextStyle(
                      fontSize: 12.0
                    ),
                    hintText: 'mm/dd/yy',
                    helperText: '*Format = mm/dd/yy',
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    ),
                    labelText: 'Date',
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, right:16.0, top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: PrimaryColorOverride(
                        color: downSalmon,
                        child: TextFormField(
                          controller: _startTimeController,
                          focusNode: _startTimeFocusNode,
                          onFieldSubmitted: (String value) {
                            FocusScope.of(context).requestFocus(_endTimeFocusNode);
                          },
                          decoration: InputDecoration(
                            helperStyle: TextStyle(
                              fontSize: 12.0
                            ),
                            hintText: 'hh:mm',
                            helperText: '*Format = hh:mm',
                            icon: Icon(
                              Icons.access_time,
                              color: Colors.black,
                           ),
                           labelText: 'Start Time',
                         ),
                        ),
                      ),
                    ),
                  ),

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: PrimaryColorOverride(
                        color: downSalmon,
                        child: TextFormField(
                          controller: _endTimeController,
                          focusNode: _endTimeFocusNode,
                          decoration: InputDecoration(
                            helperStyle: TextStyle(
                              fontSize: 12.0
                            ),
                            hintText: 'hh:mm',
                            helperText: '*Format = hh:mm',
                            icon: Icon(
                              Icons.access_time,
                              color: Colors.black,
                           ),
                           labelText: 'End Time',
                         ),
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ],
        ),
      bottomNavigationBar: ButtonTheme(
              minWidth: double.infinity,
              height: 64.0,
              child: FlatButton(
                color: downPink,
                // borderSide: BorderSide(color: Colors.black, width: 5.0),
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
                  String startTime = _startTimeController.text;
                  String endTime = _endTimeController.text;
                  String documentID = title.toLowerCase().replaceAll(' ', '')
                  + instructor.toLowerCase().replaceAll(' ', '')
                  + location.toLowerCase().replaceAll(' ', '')
                  + price.toString();

                  org = {
                  'title' : title, 
                  'instructor' : instructor,
                  'location' : location, 
                  'price' : price,
                  'date' : date,
                  'startTime' : startTime,
                  'endTime' : endTime,
                  };

                  Firestore.instance.collection('classes').document(documentID).setData(org);

                  Navigator.pop(context);
                },
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