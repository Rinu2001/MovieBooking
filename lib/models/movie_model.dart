// models/movie_model.dart
class Movie {
  final String id;
  final String title;
  final String description;
  final String posterUrl;
  final String duration;
  final List<String> genres;
  final double rating;
  final DateTime releaseDate;
  final List<String> showTimes;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.duration,
    required this.genres,
    required this.rating,
    required this.releaseDate,
    required this.showTimes,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      posterUrl: json['posterUrl'],
      duration: json['duration'],
      genres: List<String>.from(json['genres']),
      rating: json['rating'].toDouble(),
      releaseDate: DateTime.parse(json['releaseDate']),
      showTimes: List<String>.from(json['showTimes']),
    );
  }
}