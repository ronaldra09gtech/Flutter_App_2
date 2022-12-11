import 'package:cloud_firestore/cloud_firestore.dart';

class Menus
{
  String? menuID;
  String? pilamokosellerUID;
  String? menuTitle;
  String? menuInfo;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? status;

  Menus({
    this.menuID,
    this.pilamokosellerUID,
    this.menuTitle,
    this.menuInfo,
    this.publishedDate,
    this.thumbnailUrl,
    this.status,

  });

  Menus.fromJson(Map<String, dynamic> json)
  {
    menuID = json['menuID'];
    pilamokosellerUID = json['pilamokoemallUID'];
    menuTitle = json['menuTitle'];
    menuInfo = json['menuInfo'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["menuID"] = menuID;
    data['pilamokoemallUID'] = pilamokosellerUID;
    data['menuTitle'] = menuTitle;
    data['menuInfo'] = menuInfo;
    data['publishedDate'] = publishedDate;
    data['thumbnailUrl'] = thumbnailUrl;
    data['status'] = status;

    return data;
  }
}