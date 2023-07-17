import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progetto_esame/Model/Ride.dart';

import 'package:progetto_esame/Utilities/Utils.dart';
import 'package:progetto_esame/persistance/Firestore.dart';

import 'RidePage.dart';

final db_manager = Firestore.getIstance();

class StorePage extends StatefulWidget {
  @override
  _StorePage createState() => _StorePage();
}

class _StorePage extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Utils.dark_blue,
              title: const Text('Buy Ticket'),
            ),
            StreamBuilder<List<Ride>>(
                stream: db_manager!.readValidRides(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text(
                      'There are no rides',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Utils.dark_blue,
                          fontSize: 25),
                    );
                  } else if (snapshot.hasData) {
                    final rides = snapshot.data!.toList();
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: rides.length,
                      itemBuilder: (context, index) {
                        var ride = rides.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.white70, // Background color
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RidePage(
                                      id: ride.getId(),
                                      from: ride.getFrom(),
                                      to: ride.getTo(),
                                      time: ride.getDepartureTime(),
                                      seats: ride.getFreeSeats(),
                                      price: ride.getTicketPrice(),
                                      likes: ride.getLikes(),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${ride.getFrom()}-${ride.getTo()}\n${ride.getDepartureTime()}\nFree seats: ${ride.getFreeSeats()}\n${ride.getTicketPrice()}€',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Utils.dark_blue,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.add_business_sharp,
                                    size: 24,
                                    color: Utils.dark_blue,
                                  ),
                                ],
                              )),
                        );
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
