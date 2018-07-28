import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:down/bottom_bar.dart';
import 'package:down/colors.dart';
import 'package:down/date_and_time_picker.dart';

import 'package:intl/intl.dart';
import 'dart:async';

class AddClassPage extends StatefulWidget {
  Widget appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: Colors.black,
        icon: Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      backgroundColor: Color(0xffFF9391),
      elevation: 1.0,
      title: Text('Add Class',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          )),
    );
  }

  @override
  AddClassPageState createState() {
    return new AddClassPageState();
  }
}

class AddClassPageState extends State<AddClassPage> {
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _instructorController =
      new TextEditingController();
  final TextEditingController _locationController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();

  List<TextEditingController> instructorControllerList =
      new List.generate(1, (_) => new TextEditingController());

  final FocusNode _locationFocusNode = new FocusNode();
  final FocusNode _priceFocusNode = new FocusNode();

  int instructorListLength = 2;

  DateTime _date = new DateTime.now();

  List<TimeOfDay> startTimeList =
      new List.generate(1, (_) => new TimeOfDay(hour: TimeOfDay.now().hour, minute: 00,));

  List<TimeOfDay> endTimeList = 
      new List.generate(1, (_) => new TimeOfDay(hour: TimeOfDay.now().hour, minute: 30,));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: widget.appBar(context),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _titleController,
              autofocus: true,
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_locationFocusNode);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                labelText: 'Class Title',
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            child: TextField(
              controller: _locationController,
              focusNode: _locationFocusNode,
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              decoration: InputDecoration(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                labelText: 'Location',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _priceController,
              focusNode: _priceFocusNode,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.monetization_on,
                  color: Colors.black,
                ),
                labelText: 'Price',
                prefixText: '\$',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 26.0, bottom: 16.0),
            child: DateTimePicker(
              selectedDate: _date,
              selectDate: (DateTime date) {
                setState(() {
                  _date = date;
                });
              },
              isDate: true,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: instructorListLength,
              itemBuilder: (context, index) {
                return index != instructorListLength - 1
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 16.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: downSalmon,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 8.0,
                                ),
                                child: TextField(
                                  controller: instructorControllerList[index],
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.person_outline,
                                      color: Colors.black,
                                    ),
                                    labelText: 'Instructor(s)',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    top: 17.0,
                                    bottom: 16.0),
                                child: DateTimePicker(
                                  selectedStartTime: startTimeList[index],
                                  selectedEndTime: endTimeList[index],
                                  selectStartTime: (TimeOfDay time) {
                                    setState(() {
                                      startTimeList[index] = time;
                                    });
                                  },
                                  selectEndTime: (TimeOfDay time) {
                                    setState(() {
                                      endTimeList[index] = time;
                                    });
                                  },
                                  isDate: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove),
                              iconSize: 30.0,
                              color: Colors.black12,
                              onPressed: () {
                                if (instructorListLength != 2) {
                                  setState(() {
                                    instructorListLength--;
                                    instructorControllerList.removeLast();
                                    startTimeList.removeLast();
                                    endTimeList.removeLast();
                                  });
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.person_add),
                              iconSize: 30.0,
                              color: Colors.black26,
                              onPressed: () {
                                setState(() {
                                  instructorListLength++;
                                  instructorControllerList.add(new TextEditingController());
                                  startTimeList.add(endTimeList[index - 1]);
                                  endTimeList.add(newTime(endTimeList[index - 1]));
                                });
                              },
                            )
                          ],
                        ),
                      );
              },
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

            // Format conversion for date
            String date = '';
            date = new DateFormat("yMd").format(_date).toString();

            List<String> startTimeStringList = new List<String>();
            String minute, period, startTime, endTime;
            for (var i = 0; i < startTimeList.length; i++) {
              if (startTimeList[i].minute < 10) {
                minute = '0${startTimeList[i].minute}';
              } else {
                minute = startTimeList[i].minute.toString();
              }
              period = startTimeList[i].hour > 12 ? 'PM' : 'AM';
              startTime = '${startTimeList[i].hourOfPeriod.toString()}:$minute $period';

              startTimeStringList.add(startTime);
            }

            List<String> endTimeStringList = new List<String>();
            for (var i = 0; i < endTimeList.length; i++) {
              if (endTimeList[i].minute < 10) {
                minute = '0${endTimeList[i].minute}';
              } else {
                minute = endTimeList[i].minute.toString();
              }
              period = endTimeList[i].hour > 12 ? 'PM' : 'AM';
              endTime = '${endTimeList[i].hourOfPeriod.toString()}:$minute $period';

              endTimeStringList.add(endTime);
            }
            // Random 5 digit number for document ID
            var rand = new Random();
            int idNum = 10000 + rand.nextInt(89999);

            String documentID = title.toLowerCase().replaceAll(' ', '') +
                instructor.toLowerCase().replaceAll(' ', '') +
                location.toLowerCase().replaceAll(' ', '') +
                price.toString() +
                idNum.toString();

            List<String> instructorList = new List<String>();
            for (var i = 0; i < instructorControllerList.length; i++) {
              instructorList.add(instructorControllerList[i].text);
            }

            int instructorNum = instructorList.length;

            org = {
              'id': documentID,
              'title': title,
              'instructorList': instructorList,
              'instructorNum': instructorNum,
              'location': location,
              'price': price,
              'date': date,
              'startTimeList': startTimeStringList,
              'endTimeList': endTimeStringList,
            };

            Firestore.instance
                .collection('classes')
                .document(documentID)
                .setData(org);

            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  TimeOfDay newTime(TimeOfDay currentTime) {
    int newHour, newMinute;
    if (currentTime.minute >= 30) {
      newMinute = currentTime.minute - 30;
      newHour = currentTime.hour + 2;
    } else {
      newMinute = currentTime.minute + 30;
      newHour = currentTime.hour + 1;
    }
    print(newHour);
    print(newMinute);
    return new TimeOfDay(
      hour: newHour,
      minute: newMinute,
    );
  }
}
