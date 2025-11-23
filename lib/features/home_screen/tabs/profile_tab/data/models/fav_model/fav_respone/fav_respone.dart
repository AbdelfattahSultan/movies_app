import 'datum.dart';

class FavResponse {
  String? message;
  List<Datum>? favMovies;

  FavResponse({this.message, this.favMovies});

  factory FavResponse.fromJson(Map<String, dynamic> json) => FavResponse(
    message: json['message'] as String?,
    favMovies: (json['data'] as List<dynamic>?)
        ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': favMovies?.map((e) => e.toJson()).toList(),
  };
}
