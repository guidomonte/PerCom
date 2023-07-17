import 'package:progetto_esame/Model/Ride.dart';

import '../Model/AppUser.dart';
import '../Model/Ticket.dart';

abstract class Crud {
  Future createUser(AppUser user) async {}
  Stream<List<AppUser>>? readUsers() {}
  Future<AppUser?> readUser(String? id) async {}
  Stream<List<Ride>>? readValidRides() {}
  Future<Ride?> readRide(String? id) async {}
  void decrementFreeSeatsRide(String? id, int? n) {}
  void likeRide(String id) {}
  void removeLikeRide(String id) {}
  void dislikeRide(String id) {}
  void removeDislikeRide(String id) {}
  Future createTicket(List<Ticket> ts) async {}
  Stream<List<Ticket>>? readTicketsByUser(String? user) {}
  Future<Ticket?> readTicket(String? id) async {}
  void activateTicket(String? id) {}
  void setLiked(String id) {}
  void setDisliked(String id) {}
}
