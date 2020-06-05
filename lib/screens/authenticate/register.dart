import 'package:flutter/material.dart';
import 'package:uni_cart/services/auth.dart';
import 'package:uni_cart/shared/constants.dart';
import 'package:uni_cart/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // Text Field States

  String email = '';
  String password = '';
  String error = '';
  String name = '';
  String number = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return loading ? Loading() : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Header Image
                  SafeArea(
                      child: Container(
                        height: 125,
                        child: Positioned(
                          height: 125,
                          width: width + 20,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/mini.jpg'),
                                    fit: BoxFit.contain
                                )
                            ),
                          ),
                        )),
                  ),

                  SizedBox(height: 15),

                  // Login form and buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Register:",
                            style: TextStyle( color: Colors.deepOrange,fontWeight: FontWeight.bold, fontSize: 30)
                          ),
                          SizedBox(height: 15),
                          // Input Email and Password
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [ BoxShadow(color: Colors.black54, blurRadius: 2)]
                            ),
                            child: Column(
                              children: <Widget>[
                                Container( // Name
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    decoration: InputDecoration(border: InputBorder.none, hintText: "Name"),
                                    validator: (val) =>
                                        val.isEmpty ? 'Marc Devlin' : null,
                                    onChanged: (val) {
                                      setState(() => name = val);
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    decoration: InputDecoration(border: InputBorder.none, hintText: "Phone Number"),
                                    validator: (val) =>
                                        val.isEmpty ? '982111111' : null,
                                    onChanged: (val) {
                                      setState(() => number = val);
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    decoration: InputDecoration(border: InputBorder.none, hintText: "Flat Number"),
                                    validator: (val) =>
                                        val.isEmpty ? 'C-901' : null,
                                    onChanged: (val) {
                                      setState(() => address = val);
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    decoration: InputDecoration(border: InputBorder.none, hintText: "Email"),
                                    validator: (val) =>
                                        val.isEmpty ? 'name@example.com' : null,
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    decoration: InputDecoration(border: InputBorder.none, hintText: "Password"),
                                    obscureText: true,
                                    validator: (val) => val.length < 5
                                        ? 'Enter a Password atleast 5 characters long'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20), // Spacing
                          // register button
                          Center(
                            child: Container(
                                height: 40,
                                width: 120,
                                child: FlatButton(
                                  child: Text('Register',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  color: Colors.deepOrange[200],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                  onPressed: () async {
                                    // Validates if email, password are entered correctly
                                    if(_formKey.currentState.validate()){
                                      setState(() => loading = true);
                                      dynamic result = await _auth.registerWithEmailAndPassword(email, password, name, number, address);
                                      if(result == null) {
                                        setState(() {
                                          error = 'Please provide a valid email';
                                          loading = false;
                                        });
                                      }
                                    }
                                  },
                                )
                              ),
                          ),
                          // Text Widget
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text('If you have an account already, ', style: TextStyle(fontSize: 12)),
                            ),
                          ),
                          // Log In Button
                          Center(
                            child: Container(
                              height: 40,
                              width: 110,
                              child: RaisedButton(
                                child: Text('Log In', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
                                color: Colors.grey[200],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                onPressed: () => widget.toggleView(),
                              )
                            )
                          ),
                          // Centered Space
                          Center(child: SizedBox(height: 20)),
                          // Display error message
                          Center(
                            child: Text(error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
