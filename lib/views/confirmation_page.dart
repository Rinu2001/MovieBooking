// views/confirmation_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/movie_controller.dart';
import '../controllers/booking_controller.dart';
import '../models/booking_model.dart';

class ConfirmationPage extends ConsumerWidget {
  final Booking booking;

  const ConfirmationPage({super.key, required this.booking});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingAsync = ref.watch(bookingProvider(booking));
    final movie = ref.watch(selectedMovieProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
      body: bookingAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (success) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 80),
                const SizedBox(height: 16),
                const Text(
                  'Booking Confirmed!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Text('Movie: ${movie.title}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Show Time: ${booking.showTime}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Seats: ${booking.seatIds.length}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Total: \$${booking.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Reset selected seats
                    ref.read(selectedSeatsProvider.notifier).state = [];
                    ref.read(selectedShowTimeProvider.notifier).state = null;
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('Back to Home'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}