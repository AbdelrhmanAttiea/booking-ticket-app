import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile.dart'; // Import the edit profile screen
import 'Home.dart';
import 'Login_test.dart';

void main() {
  runApp(ProfileView());
}

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isDarkMode = false;
  String displayName = '';
  String email = '';
  String profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      String? userId = _auth.currentUser?.uid;
      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userId).get();
      if (userSnapshot.exists) {
        setState(() {
          displayName = userSnapshot['displayName'];
          email = userSnapshot['email'];
          profileImageUrl = userSnapshot['profileImageUrl'];
        });
      }
    } catch (e) {
      print('Failed to fetch user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          SizedBox(height: 60),
          CircleAvatar(
            radius: 40,
            backgroundImage: profileImageUrl.isNotEmpty ? NetworkImage(profileImageUrl) : AssetImage('assets/ticket.jpeg') as ImageProvider,
          ),
          SizedBox(height: 10),
          Text(
            displayName,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          Text(
            email,
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          SwitchListTile(
            title: Text('Switch to Dark Mode', style: TextStyle(color: Colors.white)),
            value: isDarkMode,
            onChanged: (bool value) {
              setState(() {
                isDarkMode = value;
              });
            },
            secondary: Icon(Icons.lightbulb_outline, color: Colors.white),
          ),
          Expanded(
            child: ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                    title: Text('Edit Profile', style: TextStyle(color: Colors.white)),
                    trailing: Icon(Icons.chevron_right, color: Colors.white),
                    onTap: () {
                      // Navigate to the edit profile screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileEditPage()),
                      );
                    },
                  ),
                  // Add other ListTiles here...
                ],
              ).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle add property
              },
              child: Text('Add Property'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle log out
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Log Out', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            child: Text('go to home page', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),

    );
  }
}
