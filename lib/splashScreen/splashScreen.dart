import 'dart:async';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../authentication/authScreen.dart';
import '../global/global.dart';
import '../mainScreens/home_Screen.dart';


class MySplashScreenMall extends StatefulWidget {
  const MySplashScreenMall({Key? key}) : super(key: key);

  @override
  _MySplashScreenMallState createState() => _MySplashScreenMallState();
}


class _MySplashScreenMallState extends State<MySplashScreenMall>
{

  startTimer()
  {
    Timer(const Duration(seconds: 3), () async {
      //if user is login already
      if(firebaseAuth.currentUser != null){
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreenEmall()));
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Image.asset("images/MALL.jpg", fit: BoxFit.cover,),
      ),
    );
  }
}
