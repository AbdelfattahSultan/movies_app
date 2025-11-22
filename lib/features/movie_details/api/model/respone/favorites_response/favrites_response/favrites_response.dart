import 'fav_movie.dart';

class FavoritesResponse {
  String? message;
  List<favMovie>? data;

  FavoritesResponse({this.message, this.data});

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    List<favMovie>? parsedData;

    if (rawData is List) {

      parsedData = rawData
          .map((e) => favMovie.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (rawData is Map<String, dynamic>) {
      parsedData = [favMovie.fromJson(rawData)];
    } else {
      parsedData = null;
    }

    return FavoritesResponse(
      message: json['message'] as String?,
      data: parsedData,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
