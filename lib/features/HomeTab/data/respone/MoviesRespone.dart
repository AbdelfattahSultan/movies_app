import 'package:movies_app/features/HomeTab/domain/model/movie.dart';

class MoviesResponse {
  final String status;
  final String statusMessage;
  final MoviesData data;

  MoviesResponse({
    required this.status,
    required this.statusMessage,
    required this.data,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    return MoviesResponse(
      status: json['status'] ?? '',
      statusMessage: json['status_message'] ?? '',
      data: MoviesData.fromJson(json['data']),
    );
  }
}

class MoviesData {
  final int movieCount;
  final int limit;
  final int pageNumber;
  final List<MovieModel> movies;

  MoviesData({
    required this.movieCount,
    required this.limit,
    required this.pageNumber,
    required this.movies,
  });

  factory MoviesData.fromJson(Map<String, dynamic> json) {
    return MoviesData(
      movieCount: json['movie_count'] ?? 0,
      limit: json['limit'] ?? 0,
      pageNumber: json['page_number'] ?? 0,
      movies: (json['movies'] as List<dynamic>?)
          ?.map((m) => MovieModel.fromJson(m))
          .toList() ??
          [],
    );
  }
}

class MovieModel {
  final int id;
  final String title;
  final String titleEnglish;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String language;
  final String backgroundImage;
  final String largeCoverImage;
  final List<TorrentModel> torrents;

  MovieModel({
    required this.id,
    required this.title,
    required this.titleEnglish,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.language,
    required this.backgroundImage,
    required this.largeCoverImage,
    required this.torrents,
  });

  Movie toMovie(){
    return Movie(
      id: id,
      title: title,
      rating: rating,
      image: largeCoverImage,
      year: year,
      genres: genres );
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleEnglish: json['title_english'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      genres: List<String>.from(json['genres'] ?? []),
      language: json['language'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      largeCoverImage: json['large_cover_image'] ?? '',
      torrents: (json['torrents'] as List<dynamic>?)
          ?.map((t) => TorrentModel.fromJson(t))
          .toList() ??
          [],
    );
  }
}

class TorrentModel {
  final String url;
  final String quality;
  final String type;
  final String size;
  final int seeds;
  final int peers;

  TorrentModel({
    required this.url,
    required this.quality,
    required this.type,
    required this.size,
    required this.seeds,
    required this.peers,
  });

  factory TorrentModel.fromJson(Map<String, dynamic> json) {
    return TorrentModel(
      url: json['url'] ?? '',
      quality: json['quality'] ?? '',
      type: json['type'] ?? '',
      size: json['size'] ?? '',
      seeds: json['seeds'] ?? 0,
      peers: json['peers'] ?? 0,
    );
  }
}