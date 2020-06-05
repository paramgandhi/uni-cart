import 'package:uni_cart/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:uni_cart/models/item.dart';
import 'package:uni_cart/services/database.dart';
import 'package:uni_cart/shared/header.dart';

class ItemPage extends StatelessWidget {

  final Item item;

  ItemPage({@required this.item});

  @override
  Widget build(BuildContext context) {

    //final users = Provider.of<List<User>>(context);
    final user = Provider.of<User>(context);
    //final items = Provider.of<List<Item>>(context);
    //final items = Provider.of<List<Item>>(context) ?? [];

    // if(item != null){
    //   print('hello');
    // }
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(    
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 25.0, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.name,
                      style: TextStyle(fontSize: 30.0, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    FlatButton(
                      child: Text('Purchase'),
                      color: Colors.green,
                      onPressed: () {
                        // Call database service, create a purchase entry in user collection with specified quantities.
                        //print(user)
                        DatabaseService().listUserData();
                      },
                    ),
                    SizedBox(height: 15),
                    FlatButton(
                      child: Text('back'),
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              )
            ],
        ),
          ),
      ),
    );
  }
}