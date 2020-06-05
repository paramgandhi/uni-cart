import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_cart/models/user.dart';
import 'package:uni_cart/screens/authenticate/authenticate.dart';
import 'package:uni_cart/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return Either Home or Authentication Widget
    
    final user = Provider.of<User>(context);
    
    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}