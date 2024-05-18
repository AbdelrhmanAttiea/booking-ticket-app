import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetailPage extends StatefulWidget {
  final String eventId;

  EventDetailPage({required this.eventId});

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late Future<DocumentSnapshot> _eventFuture;

  @override
  void initState() {
    super.initState();
    _eventFuture = FirebaseFirestore.instance.collection('events').doc(widget.eventId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _eventFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error fetching data: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return Center(child: Text("No data available"));
          }

          var event = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(event['imageUrl']),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(event['propertyName'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(event['propertyAddress']),
              ),
              // Add more widgets here to display more details
            ],
          );
        },
      ),
    );
  }
}
