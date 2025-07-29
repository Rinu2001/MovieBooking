import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/my_booking_model.dart';
import '../repositories/my_booking_repository.dart';

final myBookingRepositoryProvider = Provider<MyBookingRepository>((ref) {
  return MyBookingRepository();
});

final myBookingNotifierProvider = StateNotifierProvider<MyBookingNotifier, List<MyBooking>>((ref) {
  return MyBookingNotifier(ref);
});

class MyBookingNotifier extends StateNotifier<List<MyBooking>> {
  final Ref ref;
  
  MyBookingNotifier(this.ref) : super([]);
  
  void addBooking(MyBooking booking) {
    state = [...state, booking];
  }

  void removeBooking(num bookId) {
   // state = state.where((b) => b.bookId == bookId).toList();
  }

  void clearBookings() {
    state = [];
  }
}