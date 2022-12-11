import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/global.dart';
import '../mainScreens/home_Screen.dart';
import '../splashScreen/splashScreen.dart';
import '../widgets/customTextField.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import 'authScreen.dart';
import 'forgot_password.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void facebook() => Fluttertoast.showToast(
    msg: "Facebook register is not yet available",
    fontSize: 15,
    gravity: ToastGravity.TOP,
  );

  void google() => Fluttertoast.showToast(
    msg: "Google register is not yet available",
    fontSize: 15,
    gravity: ToastGravity.TOP,
  );

  formValidation()
  {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
    {
      //login
      loginNow();
    }
    else
    {
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: "Please write email/password.",
            );
          }
      );
    }
  }


  loginNow() async
  {
    showDialog(
        context: context,
        builder: (c)
        {
          return LoadingDialog(
            message: "Checking Credentials.",
          );
        }
    );

    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user!;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: error.message.toString(),
            );
          }
      );
    });
    if(currentUser != null)
    {
      readDataAndSetDataLocally(currentUser!);
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async
  {
    await FirebaseFirestore.instance.collection("pilamokoemall")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if(snapshot.exists)
      {

        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!.setString("userType", snapshot.data()!["userType"]);
        await sharedPreferences!.setString("name", snapshot.data()!["pilamokoemallName"]);
        await sharedPreferences!.setString("email", snapshot.data()!["pilamokoemallEmail"]);
        await sharedPreferences!.setString("photoUrl", snapshot.data()!["photoUrl"]);

        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreenEmall()));
      }
      else
      {
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));

        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(
                message: "No record found.",
              );
            }
        );
      }
    });
  }

  String status = "Unknown";
  final _connectivity = Connectivity();
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  StreamSubscription<ConnectivityResult>? _streamSubscription;

  @override
  void initState() {
    initialisedConnectivity();
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {updateConnectivityStatus(event);
    });
    super.initState();
  }

  initialisedConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    result = await _connectivity.checkConnectivity();
    updateConnectivityStatus(result);
  }

  updateConnectivityStatus(ConnectivityResult result){
    connectivityResult = result;
    switch(result){
      case ConnectivityResult.none:
        status = "Not Connected";
        break;
      case ConnectivityResult.wifi:
        status = "Connected to Wifi";
        break;
      case ConnectivityResult.mobile:
        status = "Connected to Mobile Data";
        break;
      default:
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          connectivityResult == ConnectivityResult.none ? Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            color: Colors.red[400],
            alignment: Alignment.center,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Device is in offline",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 20,
                  height: 20,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ): Container(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset(
                "images/E MALL Login.png",
                height: 300,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Email",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Password",
                  isObsecre: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
            onPressed: ()
            {
              formValidation();
            },
          ),
          const SizedBox(height: 30,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),),);
          },
            child: const Text(
              ' Forgot Password ?',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Text('Sign in with',
            style: TextStyle(fontSize: 15.0, color: Colors.white),),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //google sign in
                TextButton(
                  onPressed: () async {
                    google();
                  },
                  style: TextButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.grey),
                      minimumSize: const Size(40,40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      primary: Colors.white,
                      backgroundColor: Colors.red
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        CommunityMaterialIcons.google_plus,
                      ),
                      Text(
                          "Google"
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),

                //facebook sign in
                TextButton(
                  onPressed: ()  {
                    facebook();
                  },
                  style: TextButton.styleFrom(
                    side: const BorderSide(width: 1, color: Colors.grey),
                    minimumSize: const Size(40,40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CommunityMaterialIcons.facebook,
                      ),
                      Text(
                          "Facebook"
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
