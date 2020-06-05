import 'package:flutter/material.dart';
import 'package:uni_cart/screens/authenticate/register.dart';
import 'package:uni_cart/services/auth.dart';
import 'package:uni_cart/shared/constants.dart';
import 'package:uni_cart/shared/loading.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text Field States

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header Image
            SafeArea(
                child: Container(
                height: 200,
                child: Positioned(
                    height: 200,
                    width: width+20,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo5.png'),
                          fit: BoxFit.fitWidth
                        )
                      ),
                    ),
                  )
              ),
            ),
           
            SizedBox(height: 40),
            
            // Login form and buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                  key: _formKey,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Login", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 30)),
                    SizedBox(height: 30,),

                    // Input Email and Password
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple,
                            blurRadius: 8,
                            offset: Offset(0, 7),
                          )
                        ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: InputDecoration(border: InputBorder.none, hintText: "Email"),
                              validator: (val) => val.isEmpty ? 'name@example.com' : null,
                              onChanged: (val) {
                                setState(()=> email = val);
                              },
                            ),
                          ),
                          
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: InputDecoration(border: InputBorder.none, hintText: "Password"),
                              obscureText: true,
                              validator: (val) => val.length < 5 ? 'Enter a Password atleast 5 characters long' : null,
                              onChanged: (val) {
                                setState(()=> password = val);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 30), // Spacing

                    // Login Button
                    Center(
                      child: Container(
                        height: 40,
                        width: 120,
                        child: RaisedButton(
                          child: Text('Log In', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          color: Colors.deepPurple[500],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                          onPressed: () async {
                            // Validates if email, password are entered correctly
                            if(_formKey.currentState.validate()){
                              setState(() =>loading = true);
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                              if(result == null){
                                setState(() {
                                  error = 'Could not sign in with those credentials';
                                  loading = false;
                                });
                              }
                            }
                          },
                        )
                      ),
                    ),
                    // 'or' text
                    Center(
                      //child: SizedBox(height: 30),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('or', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),),
                      ),
                    ),
                    // register button
                    Center(
                      child: Container(
                        height: 40,
                        width: 120,
                        child: FlatButton.icon(
                          icon: Icon(Icons.person_add),
                          label: Text('Register', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                          color: Colors.deepOrange[200],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                          onPressed: () => widget.toggleView(),
                        )
                      ),
                    ),
                    Center(child: SizedBox(height:20)),
                    Center(
                      child: Text(error, style: TextStyle(color: Colors.red,fontSize: 14.0)),
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