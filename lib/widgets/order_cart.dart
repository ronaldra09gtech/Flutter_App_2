import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plmemallv3/model/items.dart';

class OrderCart extends StatelessWidget {

  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  OrderCart({
    this.seperateQuantitiesList,
    this.orderID,
    this.data,
    this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      height: itemCount! * 250,
      child: ListView.builder(
        itemCount: itemCount,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index)
        {
          Items model = Items.fromJson(data![index].data()! as Map<String, dynamic>);
          return placeOrderDesignWidget(model, context, seperateQuantitiesList![index]);
        },
      ),
    );
  }
}

Widget placeOrderDesignWidget(Items model, BuildContext context, separateQuantitiesList)
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
            model.shortInfo!,
          style: TextStyle(
            fontSize: 18
          ),
        ),
      ),
      Divider(color: Colors.grey,thickness: 1,),
      Container(
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: Row(
          children: [
            Image.network(model.thumbnailUrl!,width: 120,height: 180, fit: BoxFit.fill,),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          model.title!,
                          style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "Acme"
                          ),
                        ),
                      ),

                      const SizedBox(width: 10,),
                      const Text(
                        "₱ ",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      Text(
                        model.price.toString(),
                        style: const TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "x ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        separateQuantitiesList,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 30,
                          fontFamily: "Acme",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Divider(color: Colors.grey,thickness: 1,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              "Order Total",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
              "₱"+multiply(double.parse(model.price!.toString()), double.parse(separateQuantitiesList)),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    ],
  );
}
multiply(double price, double quantity){
  double total=0;
  total = price * quantity;
  return total.toString();
}