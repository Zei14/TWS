import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'katakata.dart'; // Pastikan untuk mengimpor halaman kata-kata

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up Page',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.blue, // Warna biru untuk AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, // Rapi dan simetris
            children: [
              // Teks Welcome
              const Center(
                child: Text(
                  'Welcome to Sign Up!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Warna biru untuk teks
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Email TextField
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                      color: Colors.blue), // Label dengan warna biru
                  filled: true,
                  fillColor: Colors
                      .blue[50], // Latar belakang input berwarna biru muda
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 20),

              // Password TextField
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                      color: Colors.blue), // Label dengan warna biru
                  filled: true,
                  fillColor: Colors
                      .blue[50], // Latar belakang input berwarna biru muda
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),

              // Sign Up Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // Warna tombol biru
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _email,
                        password: _password,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => KataKataPage()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error creating account')),
                      );
                    }
                  }
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 20),

              // Button untuk pindah ke halaman Login
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(color: Colors.blue), // Teks biru
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
