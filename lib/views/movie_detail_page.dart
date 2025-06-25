// views/movie_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/movie_controller.dart';
import 'booking_page.dart';

class MovieDetailPage extends ConsumerWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(selectedMovieProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                movie.posterUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(' ${movie.rating.toStringAsFixed(1)}'),
                      const SizedBox(width: 16),
                      const Icon(Icons.timer, size: 20),
                      Text(' ${movie.duration}'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(movie.description),
                  const SizedBox(height: 16),
                  Text(
                    'Show Times',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: movie.showTimes.map((time) {
                      return ChoiceChip(
                        label: Text(time),
                        selected: ref.watch(selectedShowTimeProvider) == time,
                        onSelected: (selected) {
                          ref.read(selectedShowTimeProvider.notifier).state =
                              selected ? time : null;
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        final selectedTime =
                            ref.read(selectedShowTimeProvider);
                        if (selectedTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Center(child: Text('Please select a show time'))),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookingPage()),
                        );
                      },
                      child: const Text('Book Tickets'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}