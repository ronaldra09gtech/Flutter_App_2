import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../authentication/authScreen.dart';
import '../global/global.dart';
import '../mainScreens/earnings_screen.dart';
import '../mainScreens/history_screen.dart';
import '../mainScreens/home_Screen.dart';
import '../mainScreens/order_screen.dart';
import '../mainScreens/profile_screen.dart';

class MyDrawer extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //drawer header
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            child:  Column(
              children:  [
                //header drawer
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            sharedPreferences!.getString("photoUrl")!
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(sharedPreferences!.getString("name")!,
                  style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Train"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12,),
          //drawer body
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.black),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreenEmall()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: const Text(
                    "Profile",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const ProfileScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.monetization_on, color: Colors.black),
                  title: const Text(
                    "My Earnings",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const EarningsScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.reorder, color: Colors.black),
                  title: const Text(
                    "Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.local_shipping, color: Colors.black),
                  title: const Text(
                    "History - Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Colors.black),
                  title: const Text(
                    "Support",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () async
                  {
                    final url = 'https://kt-portal.com/';
                    launch(url);
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),


                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.black),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    firebaseAuth.signOut().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
