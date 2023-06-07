import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_menu.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
String email="";
class home_shop extends StatefulWidget {
  final String text;
  home_shop({Key? key,required this.text}) : super(key: key);
  static String id="shop_menu";
  @override
  State<home_shop> createState() => _menuState();
}

class _menuState extends State<home_shop> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    email=widget.text;
    return Container(
      child: MessagesStream(),
    );
  }
}

class MessagesStream extends StatelessWidget {
  String shop_name="";
  Map<String, dynamic> menu=Map();
  Map<String, dynamic> orders=Map();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('shopkeepers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data?.docs;
        for (var message in messages!) {
          if(message.get("email")==email) {
            shop_name = message.get('shop_name');
            menu = message.get('menu');
            orders= message.get('orders');
          }
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('${shop_name}'),
            backgroundColor: Colors.lightBlueAccent,
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
                      child: ListTile( //use onTap method for click functionality
                        title: Text('$key'),
                        tileColor: Colors.greenAccent,
                        subtitle: Text('Price: Rs ${menu[key]}\nNumber of orders received: ${orders[key]} '),
                        onTap: () {
                        },
                      ),
                    );
                  }),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => edit_menu()),
                    );
                  },
                  child: Text('Edit menu')
              ),
            ],
          ),
        );
      },
    );
  }
}