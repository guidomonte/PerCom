import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progetto_esame/Pages/StorePage.dart';
import 'package:progetto_esame/Utilities/Utils.dart';

import 'UserPage.dart';
import 'WalletPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AppBar(
                  elevation: 0,
                  toolbarHeight: 80,
                  backgroundColor: Colors.white,
                  leadingWidth: 200,
                  leading: Image.asset('assets/image/logo.png'),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPage()));
                        },
                        child: const Icon(
                          Icons.account_circle_sharp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 100.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Utils.dark_blue,
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StorePage()));
                      },
                      child: Text("Rides"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 100.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Utils.dark_blue,
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WalletPage()));
                      },
                      child: const Text("My wallet"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
