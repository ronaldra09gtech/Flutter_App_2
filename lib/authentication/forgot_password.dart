import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../splashScreen/splashScreen.dart';
import 'authScreen.dart';
import 'authScreen1.dart';

class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  resetPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.amber,
        content: Text('Password Reset Email has benn sent!',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => MySplashScreenMall(),),);

    }on FirebaseAuthException catch(error){
      if(error.code == 'user-not-found'){
        print('No user found for that email');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber,
          content: Text('No user found for that email',
            style: TextStyle(fontSize: 18.0, color: Colors.amber),
          ),
        ),
        );

      }

    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text('Reset Password'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Image.asset("images/forget.jpg"),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text('Reset link will be send to your email ID',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Expanded(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.black26, fontSize: 15.0,
                            ),
                          ),
                          controller: emailController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please enter Email';
                            }
                            else if(!value.contains("@")){
                              return 'Please enter calid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(onPressed: (){
                              if(_formKey.currentState!.validate()){
                                setState(() {
                                  email = emailController.text;
                                });
                                resetPassword();
                              }
                            },
                              child: Text('Send email',
                                style: TextStyle(fontSize: 18.0),),
                            ),

                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen(),),);
                            },
                              child: Text('Login',
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Do not have an account ?'),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen1(),),);
                            },
                              child: Text('Signup'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
