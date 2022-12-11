import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'register 2.dart';

class AuthScreen1 extends StatefulWidget {
  const AuthScreen1({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen1> {
  Future exitDialog(){
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text('Are you sure ?'),
        content: Text('Do you want to exit from the app'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: (){
              SystemNavigator.pop();
            },
            child: Text('EXIT'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: (){
              Navigator.of(context).pop(false);
            },
            child: Text('CANCEL'),
          ),
        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        exitDialog();
        return Future.value(false);
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.lightBlueAccent,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            title: const Text(
              "PLKO MALL",
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontFamily: "Lobster",
              ),
            ),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.lock, color: Colors.white,),
                  text: "Register",
                ),
                Tab(
                  icon: Icon(Icons.person, color: Colors.white,),
                  text: "Login",
                ),
              ],
              indicatorColor: Colors.white38,
              indicatorWeight: 6,
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.lightBlueAccent,
                    Colors.blue,
                  ],
                )
            ),
            child: const TabBarView(
              children: [
                RegisterScreen(),
                LoginScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
