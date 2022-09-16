import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minimal_login/object/user.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  List<UserDetail> userList = [];

  Future<List<UserDetail>> getData() async {
    if (userList != null && userList.length > 0) {
      userList.clear();
    }
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('age', descending: false)
        .get();
    querySnapshot.docs.forEach((element) {
      userList.add(UserDetail(
          firstName: element['firstName'],
          lastName: element['lastName'],
          age: element['age'],
          email: element['email'],
          id: element.id));
    });

    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            user!.email.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();

                await googleSignIn.signOut();

                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        tileColor: Colors.grey[200],
                        leading: Text(
                            '${userList[index].firstName} ${userList[index].lastName}, ${userList[index].age} yrs.'),
                      ),
                    );
                  },
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
