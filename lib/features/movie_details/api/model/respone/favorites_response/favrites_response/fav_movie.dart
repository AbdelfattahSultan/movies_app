class favMovie {
  String? movieId;
  String? name;
  int? rating;
  String? imageUrl;
  String? year;

  favMovie({this.movieId, this.name, this.rating, this.imageUrl, this.year});

  factory favMovie.fromJson(Map<String, dynamic> json) => favMovie(
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
}
