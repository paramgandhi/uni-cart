//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_cart/models/user.dart';
import 'package:uni_cart/shared/header.dart';
import 'package:uni_cart/shared/constants.dart';
import 'package:uni_cart/services/database.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:async';




class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  String _note;
  String _price;
  String _unit;
  String _quantity;

  final f = new DateFormat.yMMMd('en_US');

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    _datePicker() async {
      DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime.now(),
        lastDate: DateTime(2021),
      );
      if (picked != null && picked != _date) {
        setState(() {
          _date = picked;
        });
      }
    }

    _timePicker() async {
      final picked = await showTimePicker(
        context: context,
        initialTime: _time,
      );
      if (picked != null && picked != _time) {
        setState(() {
          _time = picked;
        });
      }
    }

    Widget _buildDateTime() {
      return Container(
        width: 500,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Last date to order:'),
            SizedBox(width: 10.0),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(_date == null
                      ? 'Nothing has been picked yet'
                      : (f.format(_date))),
                  RaisedButton(
                    child: Text('Choose Date'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () {
                      _datePicker();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              flex: 4,
              child: Column(
                children: <Widget>[
                  Text(_time == null
                      ? 'Nothing has been picked yet'
                      : '${_time.hour}:${_time.minute}'),
                  RaisedButton(
                    child: Text('Choose Time'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () {
                      _timePicker();
                    },
                  ),
                ],
              ),
            )
            
          ],
        ),
      );
    }

    

    Widget _buildName() {
      return Row(
        children: <Widget>[
          Text('Name: '),
          SizedBox(width: 12.0),
          Flexible(
            child: TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Name'),
              validator: (val) => val.isEmpty ? 'Name cannot be empty' : null,
              onChanged: (val) {
                setState(() => _name = val);
              },
            ),
          )
        ],
      );
    }

    Widget _buildPrice() {
      return Row(
        children: <Widget>[
          Text('Price: '),
          SizedBox(width: 12.0),
          Flexible(
            child: TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Rupees'),
              validator: (val) => val.isEmpty ? 'Eg: 200' : null,
              onChanged: (val) {
                setState(() => _price = val);
              },
            ),
          ),
          SizedBox(width: 12.0),
          Text('per'),
          SizedBox(width: 12.0),
          Flexible(
            child: TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Unit'),
              validator: (val) => val.isEmpty ? 'grams' : null,
              onChanged: (val) {
                setState(() => _unit = val);
              },
            ),
          ),
        ],
      );
    }

    Widget _buildQuantity() {
      return Row(
        children: <Widget>[
          Text('Total Qty/Notes: '),
          SizedBox(width: 12.0),
          Flexible(
            child: TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: 'Available Stock, etc'),
              validator: (val) => val.isEmpty ? '4 bags' : null,
              onChanged: (val) {
                setState(() => _note = val);
              },
            ),
          )
        ],
      );
    }

    Widget _buildSubmit() {
      return Center(
        child: FlatButton(
            onPressed: () async {
              try {
                if (_formKey.currentState.validate()) {
                  await DatabaseService(uid: user.uid).addItemToList(
                      _name, _date, '${_time.hour}:${_time.minute}', _note, _price, _unit, _quantity);
                }
              } catch (e) {
                print(e.toString());
                return null;
              }
            },
            color: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text('Submit',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Header(),
            Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Your Sales',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Current Listings',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildName(),
                    SizedBox(height: 25),
                    _buildDateTime(),
                    SizedBox(height: 25),
                    _buildPrice(),
                    SizedBox(height: 15),
                    _buildQuantity(),
                    SizedBox(height: 15),
                    _buildSubmit()
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}
