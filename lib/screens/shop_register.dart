import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kriti/screens/home_shopkeeper.dart';

String email="";
class register_shop extends StatefulWidget {
  const register_shop({Key? key}) : super(key: key);
  static String id="shop_register";
  @override
  State<register_shop> createState() => _registerState();
}

class _registerState extends State<register_shop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopkeeper registration'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: MyCustomForm(),
    );
  }
}

// making form fields
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  Map menu = Map();
  Map orders=Map();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final shopnameController = TextEditingController();
  final contactnoController = TextEditingController();
  final itemController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField( //name
                  controller: nameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter your name',
                    labelText: 'Name',
                    contentPadding: EdgeInsets.all(15.0),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey,
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField( //shop name
                  controller: shopnameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter your shop name',
                    labelText: 'Shop Name',
                    contentPadding: EdgeInsets.all(15.0),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey,
                  )
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField( //contact no
                  controller: contactnoController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter your contact number',
                    labelText: 'Contact Number',
                    contentPadding: EdgeInsets.all(15.0),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey,
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField( //email
                  controller: emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter your email for registration',
                    labelText: 'Email',
                    contentPadding: EdgeInsets.all(15.0),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey,
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
                  keyboardType: TextInputType.number,
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
                  menu[itemController.text]= int.parse(priceController.text);
                  orders[itemController.text]=0;
                  email=emailController.text;
                },
                child: Text('Add menu item')
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    createShopkeeper(
                      name: nameController.text,
                      shop_name: shopnameController.text,
                      contact_no: contactnoController.text,
                      email: emailController.text,
                      menu: menu,
                      orders: orders,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => home_shop(text:email)),
                    );
                  },
                  child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  } //end of widget build context

  Future<void> createShopkeeper({required String name, required String shop_name, required String contact_no, required String email, required Map menu, required Map orders })
  async {
    print(email);

    //referencing the document
    final docShopkeeper = FirebaseFirestore.instance.collection('shopkeepers').doc(shop_name);
    final json = {
      'name': name,
      'shop_name': shop_name,
      'contact_no': contact_no,
      'email': email,
      'menu': menu,
      'orders': orders,
    };
    //create document and write to firestore
    await docShopkeeper.set(json);
  }
} //end of class





