import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minimal_login/screens/forget_password.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.showRegistration}) : super(key: key);
  Function showRegistration;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn(ctx) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.amber),
        );
      },
    );
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    )
        .catchError((error) {
      Navigator.pop(ctx);
      FocusManager.instance.primaryFocus?.unfocus();

      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(error.toString())));
      print('Sign in error: $error');
    });

    Navigator.of(ctx).pop();
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>['email']).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signInWithFacebook() async {
    FacebookAuth.instance
        .login(permissions: ['public_profile, email']).then((value) => (value) {
              FacebookAuth.instance
                  .getUserData()
                  .then((value) => (value) async {
                        print(value);
                      });
            });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

              // Icons
              const Icon(
                Icons.android,
                size: 100,
              ),
              const SizedBox(
                height: 50,
              ),

              // Title
              Text(
                "Hello Again!",
                style: GoogleFonts.bebasNeue(fontSize: 50),
              ),
              const SizedBox(
                height: 20,
              ),

              // Subtitle
              const Text(
                "You have been missed!",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // Email Field
              Padding(
                padding: const EdgeInsets.all(15),
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
                padding: const EdgeInsets.only(left: 15, right: 15),
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

              // Forget Password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ForgetPassword();
                      }));
                    },
                    child: const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text('Forget Password')),
                  ),
                ],
              ),

              // Sign in button
              Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        signIn(context);
                      },
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
                        'Sign In',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )),

              // Social Login
              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (() {
                      signInWithGoogle();
                    }),
                    child: Container(
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          'assets/images/google.png',
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: (() {
                      signInWithFacebook();
                    }),
                    child: Container(
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          'assets/images/facebook.png',
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              // Not Registered Label
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.showRegistration();
                      },
                      child: const Text('Register Now'),
                    )
                  ],
                ),
              ),

              // Poweredby label
              TextButton(
                onPressed: () async {
                  Uri url = Uri.parse(
                      "https://www.upwork.com/freelancers/~012777b91461a0a96a");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw "Could not launch $url";
                  }
                },
                child: const Text('Visit developer profile, click here!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
