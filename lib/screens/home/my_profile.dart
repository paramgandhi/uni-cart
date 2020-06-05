import 'package:flutter/material.dart';
import 'package:uni_cart/services/auth.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Text('Name: '),
          SizedBox(height: 5.0),
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: FlatButton.icon(
                onPressed: () async {
                  _auth.signOut();
                }, 
                icon: Icon(Icons.person), 
                label: Text('Log Out')
                ),
          ),
        ],
      ),
    );
  }
}
