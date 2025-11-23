import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

class HistoryLocalDataSource {
  static const String key = "history_movies";

  Future<void> saveMovie(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(key) ?? [];

    // remove existing by id (guarding against different types)
    stored.removeWhere((m) {
      try {
        final map = jsonDecode(m);
        return map["id"] == movie.id;
      } catch (_) {
        return false;
      }
    });

    final safeJson = jsonEncode({
      "id": movie.id ?? 0,
      "title": movie.title ?? "",
      "rating": movie.rating ?? 0.0,
      "image": movie.image ?? "",
      "year": movie.year ?? 0,
      "genres": movie.genres ?? [],
    });

    stored.insert(0, safeJson);

    await prefs.setStringList(key, stored.take(20).toList());
  }

  Future<List<Movie>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(key) ?? [];

    return stored.map((str) {
      try {
        final json = jsonDecode(str);
        return Movie(
          id: json["id"] is int ? json["id"] : int.tryParse(json["id"].toString()) ?? 0,
          title: json["title"]?.toString() ?? "",
          rating: (json["rating"] is num) ? (json["rating"] as num).toDouble() : double.tryParse(json["rating"].toString()) ?? 0.0,
          image: json["image"]?.toString() ?? "",
          year: (json["year"] is int) ? json["year"] : int.tryParse(json["year"].toString()) ?? 0,
          genres: (json["genres"] is List) ? List<String>.from(json["genres"].map((e) => e.toString())) : <String>[],
        );
      } catch (_) {
        // fallback empty movie if parsing fails
        return Movie(id: 0, title: "", rating: 0.0, image: "", year: 0, genres: []);
      }
    }).toList();
  }
}
