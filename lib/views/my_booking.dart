import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/my_booking_controller.dart';
import '../models/my_booking_model.dart';

class MyBookingPage extends ConsumerStatefulWidget {
  const MyBookingPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends ConsumerState<MyBookingPage> {
  @override
  Widget build(BuildContext context) {
    final bookings = ref.watch(myBookingNotifierProvider); // Watch the bookings list

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: bookings.isEmpty
          ? const Center(child: Text('No bookings yet'))
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return BookingCard(booking: booking);
              },
            ),
    );
  }
}

// Booking card widget for better organization
class BookingCard extends StatelessWidget {
  final MyBooking booking;
  
  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Booking ID: ${booking.bookId}', 
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Movie ID: ${booking.movieId}'),
            Text('Movie Name: ${booking.movieName}'),
            Text('Show Time: ${booking.showTime}'),
            Text('Seats: ${booking.seatIds.join(', ')}'),
            Text('Total: \$${booking.amount.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            // Add cancel/delete button if needed
          ],
        ),
      ),
    );
  }
}