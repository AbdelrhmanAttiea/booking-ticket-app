import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ProfileView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Edit',
      home: ProfileEditPage(),
    );
  }
}

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  String displayName = '';
  String email = '';
  String bio = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      User? user = _auth.currentUser;
      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(user?.uid).get();
      if (userSnapshot.exists) {
        setState(() {
          displayName = userSnapshot['displayName'];
          email = userSnapshot['email'];
          bio = userSnapshot['bio'];
          _nameController.text = displayName;
          _emailController.text = email;
          _bioController.text = bio;
        });
      }
    } catch (e) {
      print('Failed to fetch user data: $e');
    }
  }

  Future<void> _saveChanges() async {
    try {
      User? user = _auth.currentUser;
      await _firestore.collection('users').doc(user?.uid).update({
        'displayName': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'bio': _bioController.text.trim(),
      });
      // Show success message or navigate to previous screen upon successful update
    } catch (e) {
      print('Failed to save changes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://example.com/dog.jpg'), // Replace with your image URL
              ),
            ),
            TextButton(
              child: Text('Change Photo'),
              onPressed: () {
                // Handle change photo
              },
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                hintText: '[display_name]',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: '[email]',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _bioController,
              decoration: InputDecoration(
                labelText: 'Bio',
                hintText: '[bio]',
              ),
              maxLines: null,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('Save Changes'),
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ), backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 16.0), // Set your desired color
              ),
            ),
            ElevatedButton(
                child: Text('profileview'),
                onPressed: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );

                }

            ),


          ],
        ),
      ),
    );
  }
}
