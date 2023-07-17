import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progetto_esame/Model/Ticket.dart';
import 'package:progetto_esame/Pages/StorePage.dart';
import 'package:progetto_esame/Pages/WalletPage.dart';
import 'package:progetto_esame/persistance/Firestore.dart';
import '../Model/Ride.dart';
import '../Utilities/Utils.dart';
import 'HomePage.dart';
import 'package:equatable/equatable.dart';

final db_manager = Firestore.getIstance();

class RidePage extends StatefulWidget {
  const RidePage(
      {Key? key,
      required this.id,
      required this.from,
      required this.to,
      required this.price,
      required this.time,
      required this.seats,
      required this.likes})
      : super(key: key);
  final String id, from, to, time;
  final double price;
  final int seats, likes;
  @override
  _RidePage createState() => _RidePage();
}

class _RidePage extends State<RidePage> {
  final toast = FToast();

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  final Counter _counter = Counter();

  void _incrementCounter() {
    setState(() {
      _counter.increment();
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter.decrement();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: IconButton(
                      icon: const Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.popUntil(
                          context, ModalRoute.withName('/'))),
                ),
              ],
              backgroundColor: Utils.dark_blue,
              title: const Text('Ride'),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  '${widget.from} - ${widget.to} €${widget.price}',
                  style: const TextStyle(
                      fontSize: 25,
                      color: Utils.dark_blue,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  'Departure time: ${widget.time}',
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  'Free seats: ${widget.seats}',
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  'Likes: ${widget.likes}',
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.airplane_ticket,
                      size: 35,
                      color: Utils.dark_blue,
                    ),
                    const Text('Quantità',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    IconButton(
                        color: Utils.dark_blue,
                        onPressed:
                            _counter.value > 0 ? _decrementCounter : null,
                        icon: const Icon(Icons.indeterminate_check_box,
                            size: 40)),
                    Text(_counter.value.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    IconButton(
                        color: Utils.dark_blue,
                        onPressed: ((_counter.value < widget.seats) &
                                (_counter.value < 10))
                            ? _incrementCounter
                            : null,
                        icon: const Icon(Icons.add_box, size: 40))
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Utils.dark_blue, // Background color
                ),
                icon: const Icon(
                  Icons.add_business_sharp,
                  size: 24,
                ),
                label: const Text(
                  'Buy',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: _counter.value > 0
                    ? () {
                        buyTicket(_counter.value);
                        Utils.showOkToast(toast);
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future buyTicket(int n) async {
    List<Ticket> tickets = List.empty(growable: true);
    for (int i = 0; i < n; i++) {
      final ticket = Ticket(
          user_id: currentUser!.email,
          ride_id: widget.id,
          ticket_price: widget.price,
          activated: false,
          is_disliked: false,
          is_liked: false);
      tickets.add(ticket);
    }

    db_manager!.createTicket(tickets);
    db_manager!.decrementFreeSeatsRide(widget.id, n);
  }
}

class Counter extends Equatable {
  var value;

  Counter() {
    this.value = 1;
  }

  increment() {
    value++;
  }

  decrement() {
    value--;
  }

  @override
  List<Object?> get props => [value];
}
