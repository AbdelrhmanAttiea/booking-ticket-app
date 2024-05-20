import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'event_detail_page.dart'; // Make sure this import is correct
import 'create_event_1.dart';
import 'ProfileView.dart';
import 'main.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<QuerySnapshot> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = FirebaseFirestore.instance.collection('events').get();
  }
  int _currentIndex = 0;
  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      // Navigate to profile view page
      Navigator.push(
        context ,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else if(index == 1){
      Navigator.push(
        context ,
        MaterialPageRoute(builder: (context) => CreatePropertyPage()),
      );
    }
    else
    { Navigator.push(
      context ,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );


    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 8),
            Text('Ahmedabad, Gujarat'),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Chip(label: Text('Business')),
                Chip(label: Text('Community')),
                Chip(label: Text('Music')),
                // Add more chips here
              ],
            ),
          ),
          // Upcoming Events section
          ListTile(
            title: Text('Upcoming Events'),
            trailing: TextButton(
              child: Text('See All'),
              onPressed: () {},
            ),
          ),
          // Event items
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: _eventsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final events = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(event['imageUrl']),
                        title: Text(event['propertyName']),
                        subtitle: Text(event['propertyAddress']),
                        trailing: ElevatedButton(
                          child: Text('Buy'),
                          onPressed: () {},
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EventDetailPage(eventId: event.id)),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:_currentIndex,
        onTap: (index) => _onItemTapped(context, index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Register'),

          // Add more navigation items here
        ],
      ),
    );
  }
}