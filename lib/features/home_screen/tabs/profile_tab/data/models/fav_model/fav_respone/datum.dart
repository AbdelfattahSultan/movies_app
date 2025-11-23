import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

class Datum {
  String? movieId;
  String? name;
  int? rating;
  String? imageUrl;
  String? year;

  Datum({this.movieId, this.name, this.rating, this.imageUrl, this.year});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    movieId: json['movieId'] as String?,
    name: json['name'] as String?,
    rating: json['rating'] as int?,
    imageUrl: json['imageURL'] as String?,
    year: json['year'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'movieId': movieId,
    'name': name,
    'rating': rating,
    'imageURL': imageUrl,
    'year': year,
  };

  Movie toMovie() {
    return Movie(
      id: int.tryParse(movieId ?? ''),
      title: name ?? "",
      rating: (rating ?? 0).toDouble(),
      image: imageUrl,
      year: int.tryParse(year ?? ''),
    );
  }
}
