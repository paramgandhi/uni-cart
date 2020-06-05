import 'package:flutter/material.dart';
import 'package:uni_cart/shared/header.dart';
import 'package:uni_cart/screens/home/sell_page/item_list.dart';

class ItemCatalog extends StatefulWidget {
  @override
  _ItemCatalogState createState() => _ItemCatalogState();
}

class _ItemCatalogState extends State<ItemCatalog> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Header(),
            Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'What will you',
                    style: TextStyle(fontSize: 30.0, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'buy today?',
                    style: TextStyle(fontSize: 30.0, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 10.0),
                child: ItemList(),
              ),
            ),
          ],
        ),
    );
  }
}