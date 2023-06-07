import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kriti/screens/home_shopkeeper.dart';
import 'package:kriti/screens/login_sreen.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class edit_menu extends StatefulWidget {
  const edit_menu({Key? key}) : super(key: key);

  @override
  State<edit_menu> createState() => _edit_menuState();
}

class _edit_menuState extends State<edit_menu> {
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
  String id="";
  String item="";
  int price=0;
  final shopController = TextEditingController();
  final itemController = TextEditingController();
  final priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Menu"),
          backgroundColor: Colors.lightBlueAccent,
        ),
      body: Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField( //shop location
                  controller: shopController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter the shop name',
                    labelText: 'Shop name',
                    contentPadding: EdgeInsets.all(15.0),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.lightGreen,
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField( //shop location
                  controller: itemController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter the item on menu',
                    labelText: 'Item name',
                    contentPadding: EdgeInsets.all(15.0),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.lightGreen,
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter the price of above item',
                    labelText: 'Price',
                    contentPadding: EdgeInsets.all(15.0),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.lightGreen,
                  )
              ),
            ),
            ElevatedButton(
                onPressed: () {
                    id=shopController.text;
                    item=itemController.text;
                    price=int.parse(priceController.text);
                    updateShopkeeper(id: id, item: item, price: price);
                },
                child: Text('Add menu item')
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // updateShopkeeper();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
      )
    );
  }

  Future<void> updateShopkeeper({ required String id,required String item, required int price })
  async {
    await FirebaseFirestore.instance.collection('shopkeepers').doc(id).update(
        {'menu.${item}' : price,});
  }
}
