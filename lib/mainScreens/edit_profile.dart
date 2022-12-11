import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../global/global.dart';
import '../widgets/customTextField.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/simple_app_bar.dart';
import 'home_Screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController zoneController = TextEditingController();
  TextEditingController shopname = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  Position? position;
  List<Placemark>? placeMarks;

  String pilamokotlpImageUrl = "";
  String completeAddress = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  Future<void> formValidation() async {
    if (imageXFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return LoadingDialog(
              message: "Updating",
            );
          });
      saveDataToFirestore2();
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreenEmall()));

    } else {
      if (emailController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          locationController.text.isNotEmpty &&
          zoneController.text.isNotEmpty) {
        showDialog(
            context: context,
            builder: (c) {
              return LoadingDialog(
                message: "Updating",
              );
            });
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        fStorage.Reference reference = fStorage.FirebaseStorage.instance
            .ref()
            .child("pilamokoemall")
            .child(fileName);
        fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
        fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((url) {
          pilamokotlpImageUrl = url;

          //save info to firebase
          saveDataToFirestore();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreenEmall()));
        });
      }
    }
  }

  Future saveDataToFirestore2() async {
    FirebaseFirestore.instance
        .collection("pilamokoemall")
        .doc(sharedPreferences!.getString("uid")!)
        .update({
      "pilamokoemallEmail": emailController.text.trim(),
      "pilamokoemallName": nameController.text.trim(),
      "pilamokoemallAvatarUrl": sharedPreferences!.getString("photoUrl"),
      "phone": phoneController.text.trim(),
      "shopName": shopname.text.trim(),
      "address": completeAddress,
      "zone": zoneController.text.trim(),
      "lat": position!.latitude,
      "lng": position!.longitude,
    });

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("email", emailController.text.trim());
    await sharedPreferences!.setString("name", nameController.text.trim());
    setState(() {
      imageXFile=null;
    });
  }

  Future saveDataToFirestore() async {
    FirebaseFirestore.instance
        .collection("pilamokoemall")
        .doc(sharedPreferences!.getString("uid")!)
        .update({
      "pilamokoemallEmail": emailController.text.trim(),
      "pilamokoemallName": nameController.text.trim(),
      "pilamokoemallAvatarUrl": pilamokotlpImageUrl,
      "phone": phoneController.text.trim(),
      "shopName": shopname.text.trim(),
      "address": completeAddress,
      "lat": position!.latitude,
      "lng": position!.longitude,
      "zone": zoneController.text.trim(),
    });

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("email", emailController.text.trim());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", pilamokotlpImageUrl);
    setState(() {
      pilamokotlpImageUrl="";
    });
  }


  getCurrentLocation() async {
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    position = newPosition;

    placeMarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );

    Placemark pMark = placeMarks![0];

    completeAddress =
    '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

    locationController.text = completeAddress;
    zoneController.text = '${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea}';
  }

  @override
  void initState() {
    super.initState();

    nameController.text = sharedPreferences!.getString("name")!;
    emailController.text = email;
    phoneController.text = phone;
    locationController.text = address;
    zoneController.text = zone;
    shopname.text = shopName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "",),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                Divider(thickness: 1,color: Colors.grey,),
                Text(
                    "Profile Picture",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300
                  ),
                ),
                Center(
                  child: Stack(
                    children: [
                      InkWell(
                          onTap: () {
                            _getImage();
                          },
                          child: imageXFile == null
                              ? CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.20,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                sharedPreferences!.getString("photoUrl")!
                            ),
                          )
                              : CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.20,
                            backgroundColor: Colors.white,
                            backgroundImage: imageXFile == null
                                ? null
                                : FileImage(File(imageXFile!.path)),
                            child: imageXFile == null
                                ? Icon(
                              Icons.add_photo_alternate,
                              size: MediaQuery.of(context).size.width * 0.20,
                              color: Colors.grey,
                            )
                                : null,

                          )
                      ),
                    ],
                  ),
                ),
                Text("Note: Tap the picture to change profile picture."),
                Text("Note: Please use the shop picture."),
                Divider(thickness: 1,color: Colors.grey,),
                const SizedBox(
                  height: 15,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Full Name"),
                  ),
                ),
                CustomTextField(
                  data: Icons.person,
                  controller: nameController,
                  hintText: "Name",
                  isObsecre: false,
                ),
                Divider(thickness: 1,color: Colors.grey,),

                const SizedBox(
                  height: 15,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Email"),
                  ),
                ),
                CustomTextField(
                  data: Icons.mail,
                  controller: emailController,
                  hintText: email,
                  isObsecre: false,
                ),
                Divider(thickness: 1,color: Colors.grey,),

                const SizedBox(
                  height: 15,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Phone Nmber"),
                  ),
                ),
                CustomTextField(
                  data: Icons.phone,
                  controller: phoneController,
                  hintText: phone,
                  isObsecre: false,
                ),
                Divider(thickness: 1,color: Colors.grey,),
                const SizedBox(
                  height: 15,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Shop Name"),
                  ),
                ),
                CustomTextField(
                  data: Icons.other_houses,
                  controller: shopname,
                  hintText: "Shop Name",
                  isObsecre: false,
                ),
                Divider(thickness: 1,color: Colors.grey,),
                const SizedBox(
                  height: 15,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Shop Address"),
                  ),
                ),
                CustomTextField(
                  data: Icons.location_on,
                  controller: locationController,
                  hintText: address,
                  isObsecre: false,
                ),
                Divider(thickness: 1,color: Colors.grey,),

                const SizedBox(
                  height: 15,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Zone"),
                  ),
                ),
                CustomTextField(
                  data: Icons.location_on,
                  controller: zoneController,
                  hintText: "Zone",
                  isObsecre: false,
                ),
                Divider(thickness: 1,color: Colors.grey,),
                Text("Note: We recommend to use the button below to get your accurate SHOP ADDRESS and ZONE base on your device"),
                Container(
                  width: 400,
                  height: 40,
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    label: const Text(
                      "Get my Current Location",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      getCurrentLocation();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    formValidation();
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
