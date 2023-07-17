import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progetto_esame/Model/AppUser.dart';
import 'package:progetto_esame/main.dart';
import 'package:progetto_esame/persistance/Firestore.dart';

import 'package:progetto_esame/Utilities/Utils.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  final db_manager = Firestore.getIstance();
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Utils.dark_blue,
              title: const Text('Your Profile'),
            ),
            FutureBuilder<AppUser?>(
                future: db_manager!.readUser(currentUser?.email),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  } else if (snapshot.hasData) {
                    final user = snapshot.data;

                    return user == null
                        ? Center(child: Text('No user'))
                        : buildUser(user);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Utils.dark_blue, // Background color
                  ),
                  icon: const Icon(
                    Icons.logout_sharp,
                    size: 24,
                  ),
                  label: const Text('Logout'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUser(AppUser user) => Column(children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              '${user.getName()} ${user.getSurname()}',
              style: const TextStyle(fontSize: 20),
            )),
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              user.getId(),
              style: const TextStyle(fontSize: 20),
            )),
      ]);
}
