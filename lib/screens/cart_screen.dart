import 'package:flutter/material.dart';
import 'package:kriti/screens/payment_gateway.dart';

class CartScreen extends StatefulWidget {
  static String id='cart_screen';
  final Map<String, int> item;
  CartScreen({Key? key,required this.item}) : super(key: key);
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    num total=0;
    for (var k in (widget.item).values) {
      total=total+k;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: [
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: (widget.item).length,
              itemBuilder:(BuildContext context, int index){
                String key = (widget.item).keys.elementAt(index);
                return Column(
                  children: <Widget>[
                     ListTile(
                       leading: CircleAvatar(
                         backgroundColor: const Color(0xff6ae792),
                         child: Icon(Icons.restaurant)
                       ),
                       title: Text(
                         '${key}',
                         style: TextStyle(
                           fontSize: 20.0,
                         ),
                       ),
                       subtitle: Text('${(widget.item)[key]}'),
                       trailing: Icon(Icons.more_vert),
                    ),
                    new Divider(
                      height: 8.0,
                      thickness: 2,
                    ),
                  ],
                );
              }),
          SizedBox(
            height: 28.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Total price    ",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text("${total}",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: ()
            {
              (widget.item).clear();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Payment(total: total)),
              );
            },
            child: Text("Place Order"),
          ),
        ],
      ),
    );
  }
}
