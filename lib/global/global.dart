import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;


String email="";
String phone="";
String address="";
String number="";
String zone="";
String shopName="";
String loadWallet = "";