class Movie {
  final int? id;
  final String? title;
  final double? rating;
  final String? image;
  final int? year;
  final List<String>? genres;

  Movie({
    required this.id,
    required this.title,
    required this.rating,
    required this.image,
    required this.year,
    required this.genres,
  });
}
