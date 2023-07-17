class Ride {
  var _from, _to, _id, _ticket_price, _departure_time, _free_seats, _likes;

  Ride(
      {required String id,
      required String from,
      required String to,
      required String departure_time,
      required double ticket_price,
      required int free_seats,
      required int likes}) {
    _departure_time = departure_time;
    _from = from;
    _id = id;
    _to = to;
    _ticket_price = ticket_price;
    _free_seats = free_seats;
    _likes = likes;
  }

  String getFrom() {
    return _from;
  }

  String getTo() {
    return _to;
  }

  String getId() {
    return _id;
  }

  String getDepartureTime() {
    return _departure_time;
  }

  double getTicketPrice() {
    return _ticket_price;
  }

  int getFreeSeats() {
    return _free_seats;
  }

  int getLikes() {
    return _likes;
  }

  Map<String, dynamic> toJson() => {
        'Id': _id,
        'From': _from,
        'To': _to,
        'DepartureTime': _departure_time,
        'TicketPrice': _ticket_price,
        'FreeSeats': _free_seats,
        'Likes': _likes
      };

  static fromJson(Map<String, dynamic> json) => Ride(
      id: json['Id'],
      from: json['From'],
      to: json['To'],
      departure_time: json['DepartureTime'],
      ticket_price: json['TicketPrice'],
      free_seats: json['FreeSeats'],
      likes: json['Likes']);
}
