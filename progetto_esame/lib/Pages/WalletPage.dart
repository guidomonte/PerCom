import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progetto_esame/Model/Ride.dart';
import 'package:progetto_esame/Model/Ticket.dart';
import 'package:progetto_esame/persistance/Firestore.dart';
import 'TicketPage.dart';

import 'package:progetto_esame/Utilities/Utils.dart';

final db_manager = Firestore.getIstance();
final currentUser = FirebaseAuth.instance.currentUser;

class WalletPage extends StatefulWidget {
  @override
  _WalletPage createState() => _WalletPage();
}

class _WalletPage extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Utils.dark_blue,
              title: const Text('My Ticket'),
            ),
            StreamBuilder<List<Ticket>>(
                stream: db_manager!.readTicketsByUser(currentUser!.email),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text(
                      'You have no ticket',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Utils.dark_blue,
                          fontSize: 25),
                    );
                  } else if (snapshot.hasData) {
                    final tickets = snapshot.data!.toList();
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        var ticket = tickets.elementAt(index);
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        } else if (snapshot.hasData) {
                          return FutureBuilder<Ride?>(
                              future: db_manager!.readRide(ticket.getRideId()),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                } else if (snapshot.hasData) {
                                  final ride = snapshot.data;

                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors
                                              .white70, // Background color
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => TicketPage(
                                                ticket_id: ticket.getTicketId(),
                                                ride_id: ticket.getRideId(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${ride!.getFrom()}-${ride.getTo()}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Utils.dark_blue,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.bus_alert_outlined,
                                              size: 24,
                                              color: Utils.dark_blue,
                                            ),
                                          ],
                                        )),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              });
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
