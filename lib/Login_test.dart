import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'show_page.dart';
void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button
          },
        ),
        title: Text('Log in'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Center(child: Image.asset('assets/busuu_logo.png')), // Replace with your asset image
            SizedBox(height: 48),
            Center(
              child: Text(
                'Log in',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 48),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('Log in'),
              onPressed: () async {
                try {
                  final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                  // Navigate to the next screen upon successful login
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowPage()),
                  );

                } catch (e) {
                  // Handle login errors, such as incorrect email or password
                  print('Failed to log in: $e');
                }
              },
            ),
            SizedBox(height: 24),
            Center(
              child: Text('Does your company use single sign-on?'),
            ),
            TextButton(
              child: Text('Log in with SSO'),
              onPressed: () {
                // Handle SSO login
              },
            ),
          ],
        ),
      ),
    );
  }
}
