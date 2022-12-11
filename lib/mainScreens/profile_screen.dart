import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../global/global.dart';
import '../widgets/simple_app_bar.dart';
import 'edit_profile.dart';
import 'orders/change_pass.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  getTlpData()
  {
    FirebaseFirestore.instance
        .collection("pilamokoemall")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap){
      setState(() {
        email = snap.data()!['pilamokoemallEmail'].toString();
        phone = snap.data()!['phone'].toString();
        zone = snap.data()!['zone'].toString();
        number = snap.data()!['earning'].toString();
        loadWallet = snap.data()!['loadWallet'].toString();
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    getTlpData();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Profile",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage:
                    NetworkImage(sharedPreferences!.getString("photoUrl")!,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              alignment: Alignment.centerLeft,
              height: 15,
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text("Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: (){},
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    Expanded(child: Text(sharedPreferences!.getString('name')!, style: const TextStyle(fontSize: 15,fontFamily: "Verela", color: Colors.black),))
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 15,
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text("Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: (){},
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.mail, color: Colors.black),
                    ),
                    Expanded(child: Text(email,style: const TextStyle(fontSize: 15,fontFamily: "Verela", color: Colors.black),))
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 15,
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text("Phone Number"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: (){},
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.phone, color: Colors.black),
                    ),
                    Expanded(child: Text(phone, style: const TextStyle(fontSize: 15,fontFamily: "Verela", color: Colors.black)))
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 15,
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text("Address"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: (){},
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.location_on, color: Colors.black),
                    ),
                    Expanded(child: Text(address, style: const TextStyle(fontSize: 15,fontFamily: "Verela", color: Colors.black)))
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 15,
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text("Zone"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: (){},
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.location_on , color: Colors.black),
                    ),
                    Expanded(child: Text(zone, style: const TextStyle(fontSize: 15,fontFamily: "Verela", color: Colors.black)))
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 15,
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text("Shop Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: (){},
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.other_houses , color: Colors.black),
                    ),
                    Expanded(child: Text(shopName, style: const TextStyle(fontSize: 15,fontFamily: "Verela", color: Colors.black)))
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChangePassword();
                },
                ),
                );
              },
              child: const Text("Change Password",
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c) => const EditProfile()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blueAccent.shade400
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text("Edit Profile",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blueAccent.shade400,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



