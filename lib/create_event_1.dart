import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'create_event_part_2.dart';
void main() => runApp(CreateEvent1());

class CreateEvent1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreatePropertyPage(),
    );
  }
}

class CreatePropertyPage extends StatefulWidget {
  @override
  _CreatePropertyPageState createState() => _CreatePropertyPageState();
}

class _CreatePropertyPageState extends State<CreatePropertyPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController _propertyNameController = TextEditingController();
  final TextEditingController _propertyAddressController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late File _image;


  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _createEvent() async {
    try {
      final User? user = _auth.currentUser;
      final String? userId = user?.uid;

      // Upload image to Firebase Storage
      String imageUrl = '';
      if (_image != null) {
        final Reference ref = _storage.ref().child('event_images').child('$userId/${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(_image);
        imageUrl = await ref.getDownloadURL();
      }

      // Save event details in Firestore
      await _firestore.collection('users').doc(userId).collection('events').add({
        'propertyName': _propertyNameController.text.trim(),
        'propertyAddress': _propertyAddressController.text.trim(),
        'neighborhood': _neighborhoodController.text.trim(),
        'description': _descriptionController.text.trim(),
        'imageUrl': imageUrl,
      });

      // Navigate to the next screen or show a success message
    } catch (e) {
      print('Failed to create event: $e');
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
        title: Text('Create Property'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: _uploadImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image != null ? Image.file(_image, fit: BoxFit.cover) : Icon(Icons.camera_alt),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _propertyNameController,
                decoration: InputDecoration(
                  labelText: 'Property Name',
                  hintText: 'Something Catchy...',
                ),
              ),
              TextField(
                controller: _propertyAddressController,
                decoration: InputDecoration(
                  labelText: 'Property Address',
                  hintText: '123 Disney way here...',
                ),
              ),
              TextField(
                controller: _neighborhoodController,
                decoration: InputDecoration(
                  labelText: 'Neighborhood',
                  hintText: 'Neighborhood or city...',
                ),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Description...',
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Step 1/3'),
                  // TODO: Add step indicators if needed
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('NEXT'),
                onPressed: _createEvent,

              ),
              ElevatedButton(
                  child: Text('add more'),
                  onPressed: ()
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreatePropertyPage()),
                    );

                  }

              ),




            ],
          ),

        ),
      ),
    );
  }
}
