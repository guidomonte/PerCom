import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progetto_esame/Model/Ride.dart';
import 'package:progetto_esame/persistance/Crud.dart';
import 'package:progetto_esame/Model/AppUser.dart';

import '../Model/Ticket.dart';

class Firestore implements Crud {
  static Firestore? istance;
  final FirebaseFirestore manager = FirebaseFirestore.instance;
  final users = 'users';
  final rides = 'rides';
  final tickets = 'tickets';

  static Firestore? getIstance() {
    if (istance == null) {
      istance = Firestore();
      return istance;
    }
    return istance;
  }

  @override
  Future createUser(AppUser user) async {
    final docUser = manager.collection(users).doc(user.getId());

    final json = user.toJson();
    await docUser.set(json);
  }

  @override
  Stream<List<AppUser>>? readUsers() => FirebaseFirestore.instance
      .collection(users)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map<AppUser>((doc) => AppUser.fromJson(doc.data()))
          .toList());

  @override
  Future<AppUser?> readUser(String? id) async {
    final doc = manager.collection(users).doc(id);
    final snapshot = await doc.get();

    if (snapshot.exists) {
      return AppUser.fromJson(snapshot.data()!);
    }
    return null;
  }

  @override
  Stream<List<Ride>>? readValidRides() =>
      manager.collection(rides).snapshots().map((snapshot) => snapshot.docs
          .map<Ride>((doc) => Ride.fromJson(doc.data()))
          .where((element) => element.getFreeSeats() > 0)
          .toList());

  @override
  Stream<List<Ride>>? readRides(String) =>
      manager.collection(rides).snapshots().map((snapshot) => snapshot.docs
          .map<Ride>((doc) => Ride.fromJson(doc.data()))
          .where((element) => element.getFreeSeats() > 0)
          .toList());

  @override
  Future<Ride?> readRide(String? id) async {
    final doc = manager.collection(rides).doc(id);
    final snapshot = await doc.get();

    if (snapshot.exists) {
      return Ride.fromJson(snapshot.data()!);
    }
    return null;
  }

  @override
  void decrementFreeSeatsRide(String? id, int? n) {
    final doc = manager.collection(rides).doc(id);
    doc.update({"FreeSeats": FieldValue.increment(-n!)});
  }

  @override
  void likeRide(String? id) {
    final doc = manager.collection(rides).doc(id);
    doc.update({"Likes": FieldValue.increment(1)});
  }

  @override
  void dislikeRide(String? id) {
    final doc = manager.collection(rides).doc(id);
    doc.update({"Dislikes": FieldValue.increment(1)});
  }

  @override
  void removeLikeRide(String? id) {
    final doc = manager.collection(rides).doc(id);
    doc.update({"Likes": FieldValue.increment(-1)});
  }

  @override
  void removeDislikeRide(String? id) {
    final doc = manager.collection(rides).doc(id);
    doc.update({"Dislikes": FieldValue.increment(-1)});
  }

  @override
  Future createTicket(List<Ticket> ts) async {
    WriteBatch batch = manager.batch();
    for (Ticket ticket in ts) {
      final docUser = manager.collection(tickets).doc();
      ticket.setTicketId(docUser.id);

      final json = ticket.toJson();
      batch.set(docUser, json);
    }

    await batch.commit();
    /**
    final docUser = manager.collection(tickets).doc();
    ticket.setTicketId(docUser.id);

    final json = ticket.toJson();
    await docUser.set(json);
    */
  }

  @override
  Stream<List<Ticket>>? readTicketsByUser(String? user) =>
      manager.collection(tickets).snapshots().map((snapshot) => snapshot.docs
          .map<Ticket>((doc) => Ticket.fromJson(doc.data()))
          .where((element) => element.getUserId() == user)
          .toList());

  @override
  Future<Ticket?> readTicket(String? id) async {
    final doc = manager.collection(tickets).doc(id);
    final snapshot = await doc.get();

    if (snapshot.exists) {
      return Ticket.fromJson(snapshot.data()!);
    }
    return null;
  }

  @override
  void activateTicket(String? id) {
    final doc = manager.collection(tickets).doc(id);
    doc.update({"activated": true});
  }

  @override
  void setLiked(String? id) async {
    final doc = manager.collection(tickets).doc(id);
    final ref = await doc.get();
    Ticket value = Ticket.fromJson(ref.data()!);
    if (!value.getIsLiked()) {
      doc.update({"is_liked": true});
    } else {
      doc.update({"is_liked": false});
    }
  }

  @override
  void setDisliked(String? id) async {
    final doc = manager.collection(tickets).doc(id);
    final ref = await doc.get();
    Ticket value = Ticket.fromJson(ref.data()!);
    if (!value.getIsDisliked()) {
      doc.update({"is_disliked": true});
    } else {
      doc.update({"is_disliked": false});
    }
  }
}
