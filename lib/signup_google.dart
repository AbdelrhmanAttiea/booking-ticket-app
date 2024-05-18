import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Hello!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              'Sign up and start learning English',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Your email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Sign up logic
              },
              child: Text('Continue'),
            ),
            SizedBox(height: 8.0),
            Text(
              'Or',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            OutlinedButton.icon(
              icon: Image.asset('assets/google.png', height: 24.0), // Replace with your asset image
              label: Text('Continue with Google'),
              onPressed: () {
                // Google sign in logic
              },
            ),
            OutlinedButton.icon(
              icon: Image.asset('assets/facebook.png', height: 24.0), // Replace with your asset image
              label: Text('Continue with Facebook'),
              onPressed: () {
                // Facebook sign in logic
              },
            ),
            SizedBox(height: 20.0),
            RichText(
              text: TextSpan(
                text: 'By joining I declare that I have read and accept the ',
                style: TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Terms & Conditions',
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () {
                // Navigate to login page
              },
              child: Text('Already have an account? Log in'),
            ),
          ],
        ),
      ),
    );
  }
}