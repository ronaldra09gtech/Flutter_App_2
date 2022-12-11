import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../assistantMethods/assistant_methods.dart';
import '../../global/global.dart';
import '../../widgets/order_card.dart';
import '../../widgets/progress_bar.dart';

class CanceledOrders extends StatefulWidget {
  const CanceledOrders({Key? key}) : super(key: key);

  @override
  State<CanceledOrders> createState() => _CanceledOrdersState();
}

class _CanceledOrdersState extends State<CanceledOrders> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("orders")
          .where("sellerUID", isEqualTo: sharedPreferences!.getString("uid"))
          .where("status", whereIn: ["ended"])
          .orderBy("orderTime", descending: true)
          .snapshots(),
      builder: (c, snapshot)
      {
        return snapshot.hasData
            ? snapshot.data!.size > 0
            ? ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (c, index)
          {
            return FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("items")
                  .where("itemID", whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data()! as Map<String, dynamic>) ["productIDs"]))
                  .where("sellerUID", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
                  .orderBy("publishDate", descending: true)
                  .get(),
              builder: (c, snap)
              {
                return snap.hasData
                    ? OrderCard(
                  itemCount: snap.data!.docs.length,
                  data: snap.data!.docs,
                  orderID: snapshot.data!.docs[index].id,
                  seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"]),
                )
                    : Center(child: circularProgress());
              },
            );
          },
        )
            : Center(child: Text("There's no Order's yet"),)
            : Center(child: circularProgress(),);
      },
    );
  }
}
