// controllers/booking_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/booking_repository.dart';
import '../models/seat_model.dart';
import '../models/booking_model.dart';

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  return BookingRepository();
});

final seatsProvider = FutureProvider.family<List<Seat>, String>((ref, showTimeId) async {
  return ref.read(bookingRepositoryProvider).fetchSeats(showTimeId);
});

final selectedSeatsProvider = StateProvider<List<Seat>>((ref) => []);

final bookingProvider = FutureProvider.family<bool, Booking>((ref, booking) async {
  return ref.read(bookingRepositoryProvider).bookTickets(booking);
});