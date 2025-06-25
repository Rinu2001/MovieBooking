// controllers/movie_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/movie_repository.dart';
import '../models/movie_model.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepository();
});

final moviesProvider = FutureProvider<List<Movie>>((ref) async {
  return ref.read(movieRepositoryProvider).fetchMovies();
});

final selectedMovieProvider = StateProvider<Movie?>((ref) => null);
final selectedShowTimeProvider = StateProvider<String?>((ref) => null);