import 'package:flutter/material.dart';
// Other imports might be needed for GoogleSignIn, FacebookLogin, etc.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: login_google(),
    );
  }
}

class login_google extends StatelessWidget {
  // The FirebaseAuth instance would be used to handle sign-in.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton.icon(
              icon: Icon(Icons.email),
              label: Text('Continue with email'),
              onPressed: () {
                // Handle sign in with email
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.phone),
              label: Text('Continue with phone'),
              onPressed: () {
                // Handle sign in with phone
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.account_circle),
              label: Text('Continue with Google'),
              onPressed: () {
                // Handle sign in with Google
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.facebook),
              label: Text('Continue with Facebook'),
              onPressed: () {
                // Handle sign in with Facebook
              },
            ),
            TextButton(
              child: Text('By joining I declare that I have read and I accept the Terms & Conditions and the Privacy Policy.'),
              onPressed: () {
                // Handle terms and conditions and privacy policy
              },
            ),
          ],
        ),
      ),
    );
  }
}