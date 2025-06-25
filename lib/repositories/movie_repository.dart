// repositories/movie_repository.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/movie_model.dart';

class MovieRepository {
  Future<List<Movie>> fetchMovies() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    final String response = await rootBundle.loadString('assets/movies.json');
    final data = await json.decode(response) as List;
    return data.map((movie) => Movie.fromJson(movie)).toList();
  }
}