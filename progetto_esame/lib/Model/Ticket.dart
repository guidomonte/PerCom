import 'dart:ffi';

class Ticket {
  String? _user_id;
  var _ride_id, _ticket_id, _ticket_price, _activated, _is_liked, _is_disliked;
  Ticket(
      {required String? user_id,
      required String ride_id,
      required double ticket_price,
      required bool activated,
      required bool is_liked,
      required bool is_disliked}) {
    _user_id = user_id;
    _ride_id = ride_id;
    _ticket_id = '';
    _ticket_price = ticket_price;
    _activated = activated;
    _is_liked = is_liked;
    _is_disliked = is_disliked;
  }

  Ticket.fromTicket(
      {required String? user_id,
      required String ride_id,
      required double ticket_price,
      required String ticket_id,
      required bool activated,
      required bool is_liked,
      required bool is_disliked}) {
    _user_id = user_id;
    _ride_id = ride_id;
    _ticket_id = ticket_id;
    _ticket_price = ticket_price;
    _activated = activated;
    _is_liked = is_liked;
    _is_disliked = is_disliked;
  }

  String? getUserId() {
    return _user_id;
  }

  String getRideId() {
    return _ride_id;
  }

  String getTicketId() {
    return _ticket_id;
  }

  void setTicketId(String id) {
    _ticket_id = id;
  }

  double getTicketPrice() {
    return _ticket_price;
  }

  bool getActivated() {
    return _activated;
  }

  bool getIsLiked() {
    return _is_liked;
  }

  bool getIsDisliked() {
    return _is_disliked;
  }

  Map<String, dynamic> toJson() => {
        'ticket_id': _ticket_id,
        'user_id': _user_id,
        'ride_id': _ride_id,
        'TicketPrice': _ticket_price,
        'activated': _activated,
        'is_liked': _is_liked,
        'is_disliked': _is_disliked
      };

  static fromJson(Map<String, dynamic> json) => Ticket.fromTicket(
      ticket_id: json['ticket_id'],
      user_id: json['user_id'],
      ride_id: json['ride_id'],
      ticket_price: json['TicketPrice'],
      activated: json['activated'],
      is_liked: json['is_liked'],
      is_disliked: json['is_disliked']);
}
