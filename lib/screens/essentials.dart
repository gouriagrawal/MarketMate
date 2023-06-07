import 'package:flutter/material.dart';
import 'package:kriti/screens/restaurants.dart';
import 'package:kriti/screens/stationaries.dart';
import 'package:url_launcher/url_launcher.dart'; //flutter pub add url_launcher
class essentials extends StatefulWidget {
  const essentials({Key? key}) : super(key: key);

  @override
  State<essentials> createState() => _essentialsState();
}

class _essentialsState extends State<essentials> {
  int _selectedIndex=2;
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
    _launchWhatsapp(var whatsapp) async {
      //var whatsapp = "+91XXXXXXXXXX";
      var whatsappAndroid =Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
      if (await canLaunchUrl(whatsappAndroid)) {
        await launchUrl(whatsappAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("WhatsApp is not installed on the device"),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Essential Item Shops')),
        backgroundColor: Colors.lightBlueAccent[100],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.local_grocery_store),
              title: Text('Khokha Rentals'),
              tileColor: Colors.purple[200],
              subtitle: Text( 'Timings: 11am-9pm' ),
              onTap: ()
              {
                _launchWhatsapp("+918770024956");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.local_grocery_store),
              title: Text('Market Complex Salon'),
              tileColor: Colors.purple[200],
              subtitle: Text( 'Timings: 12pm-7pm' ),
              onTap: ()
              {
                _launchWhatsapp("+918638677934");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.local_grocery_store),
              title: Text('Market Complex supermarket'),
              tileColor: Colors.purple[200],
              subtitle: Text( 'Timings: 12pm-7pm' ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.local_grocery_store),
              title: Text('Manas Laundry'),
              tileColor: Colors.purple[200],
              subtitle: Text( 'Timings: 11am-5pm' ),
              onTap: ()
              {
                _launchWhatsapp("+917663903580");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
                leading: const Icon(Icons.local_grocery_store),
                title: Text('Khokha Cycle Repair'),
                tileColor: Colors.purple[200],
                subtitle: Text( 'Timings: 12pm-9pm' )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
                leading: const Icon(Icons.local_grocery_store),
                title: Text('Market Complex Tailor Shop'),
                tileColor: Colors.purple[200],
                subtitle: Text( 'Timings: 12pm-7pm' )
            ),
          ),
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
  }
}
