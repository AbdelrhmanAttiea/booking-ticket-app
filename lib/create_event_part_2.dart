import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CreateEventPart2App());
}

class CreateEventPart2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Event Part 2',
      home: CreatePropertyPage(),
    );
  }
}

class CreatePropertyPage extends StatefulWidget {
  @override
  _CreatePropertyPageState createState() => _CreatePropertyPageState();
}

class _CreatePropertyPageState extends State<CreatePropertyPage> {
  int minimumNightStay = 1;
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _taxRateController = TextEditingController();
  final TextEditingController _cleaningFeeController = TextEditingController();
  final TextEditingController _additionalNotesController = TextEditingController();

  Future<void> _addEvent() async {
    try {
      // Save event data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('events').add({
        'pricePerNight': _priceController.text,
        'minimumNightStay': minimumNightStay,
        'taxRate': _taxRateController.text,
        'cleaningFee': _cleaningFeeController.text,
        'additionalNotes': _additionalNotesController.text,
        // Add more fields as needed
      });

      // Data sent to Firestore successfully
      print('Event data added to Firestore');
    } catch (e) {
      // Error occurred during data sending
      print('Error adding event data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Create Property'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text('PRICE PER NIGHT', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Price',
                prefixText: '\$',
              ),
            ),
            SizedBox(height: 20),
            Text('MINIMUM NIGHT STAY', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (minimumNightStay > 1) {
                      setState(() {
                        minimumNightStay--;
                      });
                    }
                  },
                ),
                Text('$minimumNightStay'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      minimumNightStay++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('TAX RATE', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _taxRateController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Rate',
                suffixText: '%',
              ),
            ),
            SizedBox(height: 20),
            Text('CLEANING FEE', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _cleaningFeeController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Price',
                prefixText: '\$',
              ),
            ),
            SizedBox(height: 20),
            Text('ADDITIONAL NOTES', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _additionalNotesController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Additional notes...',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Add Event'),
              onPressed: _addEvent,

            ),
            ElevatedButton(
                child: Text('go'),
                onPressed:()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );

                }

            ),
          ],
        ),
      ),
    );
  }
}
