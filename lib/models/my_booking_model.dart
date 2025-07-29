class MyBooking {
  final String bookId;
  final String movieId;
  final String movieName;
  final String showTime;
  final List<String> seatIds;
  final num seat;
  final double amount;

  MyBooking({
    required this.bookId,
    required this.movieId,
    required this.movieName,
    required this.showTime,
    required this.seatIds,
    required this.seat,
    required this.amount,
  });

  factory MyBooking.fromJson(Map<String, dynamic> json) {
    return MyBooking(
      bookId: json['bookId'],
      movieId: json['movieId'] as String,
      movieName: json['movieName'] as String,
      showTime: json['showTime'] as String,
      seatIds: List<String>.from(json['seatIds']),
      seat: json['seat'] as num,
      amount: (json['amount'] as num).toDouble(),
    );
  }
}