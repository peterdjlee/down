import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDropdown extends StatelessWidget {
  const InputDropdown({
    Key key,
    this.child,
    this.valueText,
    this.onPressed,
    this.isDate}) : super(key: key);

  final String valueText;
  final VoidCallback onPressed;
  final Widget child;
  final bool isDate;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          isDate 
          ? new Icon(Icons.calendar_today) 
          : new Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: Icon(Icons.access_time)
          ),
          new Text(valueText),
          new Icon(Icons.arrow_drop_down,
            color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70
          ),
        ],
      ),
    );
  }
}

class DateTimePicker extends StatelessWidget {
  DateTimePicker({
    Key key,
    this.selectedDate,
    this.selectedStartTime,
    this.selectedEndTime,
    this.selectDate,
    this.selectStartTime,
    this.selectEndTime,
    this.isDate
  }) : super(key: key);

  final DateTime selectedDate;
  final TimeOfDay selectedStartTime;
  final TimeOfDay selectedEndTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectStartTime;
  final ValueChanged<TimeOfDay> selectEndTime;
  final bool isDate;

  String date;
  String startTime;
  String endTime;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: new DateTime(2015, 8),
      lastDate: new DateTime(2101)
    );
    if (picked != null && picked != selectedDate) {
      selectDate(picked);
    }
  }

  Future<Null> _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime
    );
    
    if (picked != null && picked != selectedStartTime) {
      selectStartTime(picked);
    }
  }

  Future<Null> _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime
    );

    if (picked != null && picked != selectedEndTime) {
      selectEndTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        isDate
        ?
        new Expanded(
          flex: 4,
          child:
          new InputDropdown(
            valueText: new DateFormat.yMMMd().format(selectedDate),
            isDate: true,
            onPressed: () { _selectDate(context); },
          )
        )
        :
        new Expanded(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new InputDropdown(
                valueText: selectedStartTime.format(context),
                isDate: false,
                onPressed: () { _selectStartTime(context); },
              ),
              new Icon(Icons.arrow_forward),
              new InputDropdown(
                valueText: selectedEndTime.format(context),
                isDate: false,
                onPressed: () { _selectEndTime(context); },
              ),
            ],
          ),
        )
      ],
    );
  }
}