// controllers/booking_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/booking_repository.dart';
import '../models/seat_model.dart';
import '../models/booking_model.dart';
import 'my_booking_controller.dart';

// 1. Repository Provider
final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  return BookingRepository();
});

// 2. Seats Provider with error handling
// In the seatsProvider
final seatsProvider = FutureProvider.family<List<Seat>, String>((ref, showTimeId) async {
  try {
    final repository = ref.read(bookingRepositoryProvider);
    final seats = await repository.fetchSeats(showTimeId);
    
    // Get booked seats to update availability
    final bookings = ref.watch(myBookingNotifierProvider);
    final bookedSeatIds = bookings.expand((b) => b.seatIds).toList();
    
    return seats.map((seat) {
      // Only update availability if seat is booked
      if (bookedSeatIds.contains(seat.id)) {
        return seat.copyWith(isAvailable: false);
      }
      return seat; // Keep original availability for other seats
    }).toList();
  } catch (e) {
    throw Exception('Failed to load seats: $e');
  }
});

// 3. Selected Seats Provider
final selectedSeatsProvider = StateProvider<List<Seat>>((ref) => []);

// 4. Booking Provider with proper error handling
final bookingProvider = AsyncNotifierProviderFamily<BookingNotifier, bool, Booking>(
  BookingNotifier.new,
);

class BookingNotifier extends FamilyAsyncNotifier<bool, Booking> {
  @override
  Future<bool> build(Booking arg) async {
    // Initial build - no data loaded yet
    return false;
  }

  Future<void> submitBooking() async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(bookingRepositoryProvider);
      final success = await repository.bookTickets(arg);
      state = AsyncData(success);
      
      // Clear selected seats after successful booking
      if (success) {
        ref.read(selectedSeatsProvider.notifier).state = [];
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

// 5. Additional Provider for booking status
final bookingStatusProvider = StateProvider<BookingStatus>((ref) {
  return BookingStatus.initial;
});

enum BookingStatus {
  initial,
  loading,
  success,
  failed,
}