// views/booking_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/movie_controller.dart';
import '../controllers/booking_controller.dart';
import '../models/booking_model.dart';
import '../models/seat_model.dart';
import 'confirmation_page.dart';

class BookingPage extends ConsumerWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(selectedMovieProvider)!;
    final showTime = ref.watch(selectedShowTimeProvider)!;
    final seatsAsync = ref.watch(seatsProvider(showTime));
    final selectedSeats = ref.watch(selectedSeatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Seats for ${movie.title}'),
      ),
      body: seatsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (seats) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HintText(Colors.blue, 'Available'),
                    HintText(Colors.grey, 'Unavailable'),
                    HintText(Colors.green, 'Selected'),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Screen',
                        style: TextStyle(fontSize: 18),
                      ),
                     Container(
                      height: 20,
                      width: 300,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey,
                            width: 5,
                          ),
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.elliptical(150, 20), 
                        ),
                      ),
                      
                    ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                            childAspectRatio: 1,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: seats.length,
                          itemBuilder: (context, index) {
                            final seat = seats[index];
                            return SeatWidget(seat: seat);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Show Time: $showTime',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Selected Seats: ${selectedSeats.map((s) => '${s.row}${s.number}').join(', ')}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total: \$${(selectedSeats.length * 12.50).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: selectedSeats.isEmpty
                          ? null
                          : () {
                              final booking = Booking(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                movieId: movie.id,
                                showTime: showTime,
                                seatIds: selectedSeats.map((s) => s.id).toList(),
                                bookingDate: DateTime.now(),
                                totalPrice: selectedSeats.length * 12.50,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfirmationPage(booking: booking),
                                ),
                              );
                            },
                      child: const Text('Confirm Booking'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HintText extends StatelessWidget {
  final Color color;
  final String text;
  
  const HintText(this.color, this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.square, color: color, size: 20),
        Text(' $text'),
      ],
    );
  }
}

class SeatWidget extends ConsumerWidget {
  final Seat seat;

  const SeatWidget({super.key, required this.seat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSeats = ref.watch(selectedSeatsProvider);
    final isSelected = selectedSeats.contains(seat);

    return GestureDetector(
      onTap: () {
        if (!seat.isAvailable) return;
        
        ref.read(selectedSeatsProvider.notifier).state = isSelected
            ? selectedSeats.where((s) => s != seat).toList()
            : [...selectedSeats, seat];
      },
      child: Container(
        decoration: BoxDecoration(
          color: !seat.isAvailable
              ? Colors.grey
              : isSelected
                  ? Colors.green
                  : Colors.blue,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            '${seat.row}${seat.number}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}