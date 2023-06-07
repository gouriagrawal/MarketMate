import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cart_screen.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
String shop="";

class menu extends StatefulWidget {
  final String text;
  menu({Key? key, required this.text}) : super(key: key);
  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  final messageTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    shop=widget.text;
    return Container(
      child: MessagesStream(),
    );
  }
}

class MessagesStream extends StatelessWidget {
  late Map<String, dynamic> menu;
  // Map<String,int> cart_items=Map();
  Map<String,int> cart_items={'pizza':150,'burger':75,'pasta': 100 ,'cold drink':20, 'gulab jamun': 25};
  Map orders=Map();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('shopkeepers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data?.docs;
        for (var message in messages!) {
          if(message.get('shop_name')==shop) {
            orders=message.get('orders');
            menu = message.get('menu');
          }
        }
        Future<void> updateShopkeeper({ required String shop,required String item})
        async {
          // for(var x in menu.keys){
          //   cart_items[x]=0;
          // }
          await FirebaseFirestore.instance.collection('shopkeepers').doc(shop).update(
              {'orders.${item}' : orders[item]+1,});
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("${shop}"),
          ),
          body: Column(
            children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: menu.length,
                  itemBuilder:(BuildContext context, int index){
                    String key = menu.keys.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile( // use onTap method for click functionality
                        title: Text('$key'),
                        trailing: const Icon(Icons.add),
                        tileColor: Colors.greenAccent,
                        subtitle: Text('Price: Rs ${menu[key]}'),
                        onTap: () {
                            int price=menu[key] as int;
                            updateShopkeeper(shop:shop,item:key);
                            // cart_items[key]=((cart_items[key]??0)+(price));
                        },
                      ),
                    );
                  }),
              const SizedBox(
                width: 200.0,
                height: 8.0,
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(item: cart_items)),
              );
            },
            child: Icon(Icons.add_shopping_cart_rounded),
          ),
        );
      },
    );
  }
}