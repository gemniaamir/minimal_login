import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  final _emailController = TextEditingController();

  Future sendEmail() async {
    try {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text('Reset Password')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'Please provide your email address. We will send an email'),

              // Email Field
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    child: TextField(
                      controller: _emailController,
                      cursorColor: Colors.black54,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15),
                          border: InputBorder.none,
                          hintText: 'Email'),
                    ),
                  ),
                ),
              ),

              // Reset Button
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: sendEmail,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.deepPurple),
                      ),
                      child: const Text(
                        'Send Email',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
