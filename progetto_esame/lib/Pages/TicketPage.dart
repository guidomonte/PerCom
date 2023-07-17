import 'package:flutter/material.dart';
import 'package:progetto_esame/Model/Ride.dart';
import 'package:progetto_esame/Model/Ticket.dart';

import 'package:progetto_esame/Utilities/Utils.dart';
import 'package:progetto_esame/persistance/Firestore.dart';

import 'package:qr_flutter/qr_flutter.dart';

final db_manager = Firestore.getIstance();

class TicketPage extends StatefulWidget {
  const TicketPage({Key? key, required this.ticket_id, required this.ride_id})
      : super(key: key);
  final String ticket_id, ride_id;

  @override
  _TicketPage createState() => _TicketPage();
}

class _TicketPage extends State<TicketPage> {
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
              title: const Text('Ticket'),
            ),
            FutureBuilder<Ride?>(
                future: db_manager!.readRide(widget.ride_id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.hasData) {
                    final ride = snapshot.data;

                    return Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              widget.ticket_id,
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Utils.dark_blue,
                                  fontWeight: FontWeight.bold),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              '${ride?.getFrom()} - ${ride?.getTo()} €${ride?.getTicketPrice()}',
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Utils.dark_blue,
                                  fontWeight: FontWeight.bold),
                            )),
                        FutureBuilder<Ticket?>(
                            future: db_manager!.readTicket(widget.ticket_id),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              } else if (snapshot.hasData) {
                                bool state = snapshot.data!.getActivated();
                                bool isLiked = snapshot.data!.getIsLiked();
                                bool isDisliked =
                                    snapshot.data!.getIsDisliked();
                                return Padding(
                                  padding: const EdgeInsets.only(top: 60.0),
                                  child: state
                                      ? Column(
                                          children: <Widget>[
                                            QrImage(
                                              data:
                                                  '${widget.ride_id}\n${ride!.getFrom()}-${ride.getTo()}',
                                              version: QrVersions.auto,
                                              size: 200.0,
                                            ),
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 60.0),
                                                child: Text(
                                                  'Did you like the ride?',
                                                  style: TextStyle(
                                                      color: Utils.dark_blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (isLiked) {
                                                        db_manager!
                                                            .removeLikeRide(
                                                                widget.ride_id);
                                                      } else {
                                                        db_manager!.likeRide(
                                                            widget.ride_id);
                                                        if (isDisliked !=
                                                            isLiked) {
                                                          db_manager!
                                                              .removeDislikeRide(
                                                                  widget
                                                                      .ride_id);
                                                          db_manager!
                                                              .setDisliked(widget
                                                                  .ticket_id);
                                                        }
                                                      }

                                                      db_manager!.setLiked(
                                                          widget.ticket_id);
                                                    });
                                                  },
                                                  icon: Icon(Icons.thumb_up,
                                                      color: isLiked
                                                          ? Utils.dark_blue
                                                          : Colors.grey),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (isDisliked) {
                                                        db_manager!
                                                            .removeDislikeRide(
                                                                widget.ride_id);
                                                      } else {
                                                        db_manager!.dislikeRide(
                                                            widget.ride_id);
                                                        if (isDisliked !=
                                                            isLiked) {
                                                          db_manager!
                                                              .removeLikeRide(
                                                                  widget
                                                                      .ride_id);
                                                          db_manager!.setLiked(
                                                              widget.ticket_id);
                                                        }
                                                      }

                                                      db_manager!.setDisliked(
                                                          widget.ticket_id);
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.thumb_down,
                                                    color: isDisliked
                                                        ? Utils.dark_blue
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Utils
                                                .dark_blue, // Background color
                                          ),
                                          icon: const Icon(
                                            Icons.bus_alert_outlined,
                                            size: 24,
                                          ),
                                          label: const Text(
                                            'Activate',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              db_manager!.activateTicket(
                                                  widget.ticket_id);
                                            });
                                          }),
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
