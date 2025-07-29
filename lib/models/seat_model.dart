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


  // Helper method to create a copy with modified fields
  Seat copyWith({
    String? id,
    String? row,
    int? number,
    bool? isAvailable,
    bool? isSelected,
  }) {
    return Seat(
      id: id ?? this.id,
      row: row ?? this.row,
      number: number ?? this.number,
      isAvailable: isAvailable ?? this.isAvailable,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      row: json['row'],
      number: json['number'],
      isAvailable: json['isAvailable'],
    );
  }
}