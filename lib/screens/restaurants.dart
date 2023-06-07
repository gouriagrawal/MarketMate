import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kriti/screens/essentials.dart';
import 'package:kriti/screens/shop_menu.dart';
import 'package:kriti/screens/stationaries.dart';

class restaurants extends StatefulWidget {
  const restaurants({Key? key}) : super(key: key);
  @override
  State<restaurants> createState() => _restaurantsState();
}

class _restaurantsState extends State<restaurants> {
  int _selectedIndex=0;
  final _firestore = FirebaseFirestore.instance;
  late String shop_name;
  List<String> shops=[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index==0){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => restaurants()),
        );
      }
      if(index==1){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => stationaries()),
        );
      }
      if(index==2){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => essentials()),
        );
      }
    });
  }

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
          shop_name = message.get('shop_name');
          shops.add(shop_name);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Restaurants"),
          ),
          body: Column(
            children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: shops.length,
                itemBuilder:(BuildContext context, int index){
                  String key = shops[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('$key'),
                      leading: const Icon(Icons.coffee),
                      tileColor: Colors.purple[200],
                      subtitle: Text( 'Status: open/closed' ),
                      onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => menu( text : shops[index])),
                          );
                        },
                    ),
                  );
                }),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: 'Restaurants',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.scanner),
                label: 'Statioaries',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_laundry_service),
                label: 'Essentials',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
