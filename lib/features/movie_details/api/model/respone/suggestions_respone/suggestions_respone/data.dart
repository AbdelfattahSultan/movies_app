import 'similar_movie.dart';

class Data {
  int? movieCount;
  List<SimilarMovie>? movies;

  Data({this.movieCount, this.movies});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    movieCount: json['movie_count'] as int?,
    movies: (json['movies'] as List<dynamic>?)
        ?.map((e) => SimilarMovie.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'movie_count': movieCount,
    'movies': movies?.map((e) => e.toJson()).toList(),
  };
}
