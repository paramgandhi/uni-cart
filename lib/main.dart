import 'package:flutter/material.dart';
import 'package:uni_cart/models/item.dart';
import 'package:uni_cart/models/user.dart';
import 'package:uni_cart/screens/home/my_profile.dart';
import 'package:uni_cart/screens/home/sell_page/item_page.dart';
import 'package:uni_cart/services/auth.dart';
import 'package:uni_cart/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        //initialRoute: '/',
        routes: {
          //'/': (context) => Wrapper(),
          //'/addItem': (context) => AddItemForm(),
          '/profile': (context) => MyProfile(),
          //'/item_page': (context) => ItemPage(item: Item()),
        },
        home: Wrapper(),
      ),
    );
  }
}
