// models/seat_model.dart
class Seat {
  final String id;
  final String row;
  final int number;
  bool isAvailable;
  bool isSelected;

  Seat({
    required this.id,
    required this.row,
    required this.number,
    this.isAvailable = true,
    this.isSelected = false,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      row: json['row'],
      number: json['number'],
      isAvailable: json['isAvailable'],
    );
  }
}