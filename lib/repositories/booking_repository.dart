// repositories/booking_repository.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/seat_model.dart';
import '../models/booking_model.dart';

class BookingRepository {
  Future<List<Seat>> fetchSeats(String showTimeId) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    final String response = await rootBundle.loadString('assets/seats.json');
    final data = await json.decode(response) as List;
    return data.map((seat) => Seat.fromJson(seat)).toList();
  }

  Future<bool> bookTickets(Booking booking) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return true; // Simulate successful booking
  }
}