// models/booking_model.dart
class Booking {
  final String id;
  final String movieId;
  final String showTime;
  final List<String> seatIds;
  final DateTime bookingDate;
  final double totalPrice;

  Booking({
    required this.id,
    required this.movieId,
    required this.showTime,
    required this.seatIds,
    required this.bookingDate,
    required this.totalPrice,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      movieId: json['movieId'],
      showTime: json['showTime'],
      seatIds: List<String>.from(json['seatIds']),
      bookingDate: DateTime.parse(json['bookingDate']),
      totalPrice: json['totalPrice'].toDouble(),
    );
  }
}