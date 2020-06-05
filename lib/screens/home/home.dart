import 'package:flutter/material.dart';
import 'package:uni_cart/screens/home/sell_page/item_catalog.dart';
import 'package:uni_cart/screens/home/my_profile.dart';
import 'package:uni_cart/services/auth.dart';
import 'package:uni_cart/services/database.dart';
import 'package:provider/provider.dart';
import 'package:uni_cart/models/user.dart';
import 'package:uni_cart/models/item.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:uni_cart/screens/home/buy_page/add_item.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  int _selectedIndex = 0;

  final tabs = [
    new ItemCatalog(),
    new AddItem(),
    new Scaffold(body: Text('Cart')),
    new Scaffold(body: Text('Favourites'))
  ];

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return MultiProvider(
      providers: [
        StreamProvider.value(value: DatabaseService().items),
        StreamProvider.value(value: DatabaseService().users)
      ],
      child: SafeArea(
          child: Scaffold(
          backgroundColor: Colors.white,
          body: tabs[_selectedIndex],

          bottomNavigationBar: BubbleBottomBar(
            opacity: 0.2,
            currentIndex: _selectedIndex,
            onTap: (index){
              setState(() => _selectedIndex = index);
            },
            borderRadius: BorderRadius.all(Radius.circular(50)),
            elevation: 8,
            hasNotch: true,
            hasInk: true,
            inkColor: Colors.black38,
            items: <BubbleBottomBarItem> [
              BubbleBottomBarItem(
                backgroundColor: Colors.deepOrange,
                icon: Icon(Icons.dashboard, color: Colors.black54),
                activeIcon: Icon(Icons.dashboard, color: Colors.deepOrange),
                title: Text('Buy')
              ),
              BubbleBottomBarItem(
                backgroundColor: Colors.blue[900],
                icon: Icon(Icons.local_atm, color: Colors.black54),
                activeIcon: Icon(Icons.local_atm, color:  Colors.blue[900]),
                title: Text('Sell')
              ),
              BubbleBottomBarItem(
                backgroundColor: Colors.green,
                icon: Icon(Icons.local_grocery_store, color: Colors.black54),
                activeIcon: Icon(Icons.local_grocery_store, color: Colors.green),
                title: Text('Cart')
              ),
              BubbleBottomBarItem(
                backgroundColor: Colors.pink,
                icon: Icon(Icons.favorite_border, color: Colors.black54),
                activeIcon: Icon(Icons.favorite_border, color: Colors.pink),
                title: Text('Favourites')
              )
            ],
          ),
          
      ),
        ),
    );
  }
}