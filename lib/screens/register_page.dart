import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterationPage extends StatefulWidget {
  VoidCallback showLoginPage;
  RegisterationPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterationPage> createState() => _RegisterationPageState();
}

class _RegisterationPageState extends State<RegisterationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  Future signUp() async {
    if (confirmPassword()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      // Add other details to Firestore
      addDetails();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password doesn\'t matches')));
    }
  }

  Future addDetails() async {
    try {
      FirebaseFirestore.instance.collection('users').add({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'age': _ageController.text.trim(),
        'email': _emailController.text.trim(),
      });
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  bool confirmPassword() {
    if (_confirmPasswordController.text.trim() ==
        _passwordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),

              // Title
              Text(
                "Hello There!",
                style: GoogleFonts.bebasNeue(fontSize: 50),
              ),
              const SizedBox(
                height: 20,
              ),

              // Subtitle
              const Text(
                "Register below with your email",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // First Name Field
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: TextField(
                    controller: _firstNameController,
                    cursorColor: Colors.black54,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15),
                      border: InputBorder.none,
                      hintText: 'First Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),

              // Last Name Field
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: TextField(
                    controller: _lastNameController,
                    cursorColor: Colors.black54,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15),
                      border: InputBorder.none,
                      hintText: 'Last Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),

              // Age Field
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    cursorColor: Colors.black54,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15),
                      border: InputBorder.none,
                      hintText: 'Age',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),

              // Email Field
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: TextField(
                    controller: _emailController,
                    cursorColor: Colors.black54,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15),
                      border: InputBorder.none,
                      hintText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),

              // Password field
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: TextField(
                    cursorColor: Colors.black54,
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15),
                      border: InputBorder.none,
                      hintText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // confirm password field
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: TextField(
                    cursorColor: Colors.black54,
                    obscureText: true,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15),
                      border: InputBorder.none,
                      hintText: 'Confirm Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // Sign in button
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: signUp,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.deepPurple),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ))),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )),

              // Not Registered Label
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'I am a member?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.showLoginPage();
                      },
                      child: const Text('Login Now'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
