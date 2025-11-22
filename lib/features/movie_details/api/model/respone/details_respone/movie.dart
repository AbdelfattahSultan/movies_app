import 'cast.dart';
import 'torrent.dart';

class MovieDetails {
  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  int? likeCount;
  String? descriptionIntro;
  String? descriptionFull;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? mediumScreenshotImage1;
  String? mediumScreenshotImage2;
  String? mediumScreenshotImage3;
  String? largeScreenshotImage1;
  String? largeScreenshotImage2;
  String? largeScreenshotImage3;
  List<Cast>? cast;
  List<Torrent>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

  MovieDetails({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.likeCount,
    this.descriptionIntro,
    this.descriptionFull,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.mediumScreenshotImage1,
    this.mediumScreenshotImage2,
    this.mediumScreenshotImage3,
    this.largeScreenshotImage1,
    this.largeScreenshotImage2,
    this.largeScreenshotImage3,
    this.cast,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
    id: json['id'] as int?,
    url: json['url'] as String?,
    imdbCode: json['imdb_code'] as String?,
    title: json['title'] as String?,
    titleEnglish: json['title_english'] as String?,
    titleLong: json['title_long'] as String?,
    slug: json['slug'] as String?,
    year: json['year'] as int?,
    rating: (json['rating'] as num?)?.toDouble(),
    runtime: json['runtime'] as int?,
    genres: (json['genres'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
    likeCount: json['like_count'] as int?,
    descriptionIntro: json['description_intro'] as String?,
    descriptionFull: json['description_full'] as String?,
    ytTrailerCode: json['yt_trailer_code'] as String?,
    language: json['language'] as String?,
    mpaRating: json['mpa_rating'] as String?,
    backgroundImage: json['background_image'] as String?,
    backgroundImageOriginal: json['background_image_original'] as String?,
    smallCoverImage: json['small_cover_image'] as String?,
    mediumCoverImage: json['medium_cover_image'] as String?,
    largeCoverImage: json['large_cover_image'] as String?,
    mediumScreenshotImage1: json['medium_screenshot_image1'] as String?,
    mediumScreenshotImage2: json['medium_screenshot_image2'] as String?,
    mediumScreenshotImage3: json['medium_screenshot_image3'] as String?,
    largeScreenshotImage1: json['large_screenshot_image1'] as String?,
    largeScreenshotImage2: json['large_screenshot_image2'] as String?,
    largeScreenshotImage3: json['large_screenshot_image3'] as String?,
    cast: (json['cast'] as List<dynamic>?)
        ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
        .toList(),
    torrents: (json['torrents'] as List<dynamic>?)
        ?.map((e) => Torrent.fromJson(e as Map<String, dynamic>))
        .toList(),
    dateUploaded: json['date_uploaded'] as String?,
    dateUploadedUnix: json['date_uploaded_unix'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
    'imdb_code': imdbCode,
    'title': title,
    'title_english': titleEnglish,
    'title_long': titleLong,
    'slug': slug,
    'year': year,
    'rating': rating,
    'runtime': runtime,
    'genres': genres,
    'like_count': likeCount,
    'description_intro': descriptionIntro,
    'description_full': descriptionFull,
    'yt_trailer_code': ytTrailerCode,
    'language': language,
    'mpa_rating': mpaRating,
    'background_image': backgroundImage,
    'background_image_original': backgroundImageOriginal,
    'small_cover_image': smallCoverImage,
    'medium_cover_image': mediumCoverImage,
    'large_cover_image': largeCoverImage,
    'medium_screenshot_image1': mediumScreenshotImage1,
    'medium_screenshot_image2': mediumScreenshotImage2,
    'medium_screenshot_image3': mediumScreenshotImage3,
    'large_screenshot_image1': largeScreenshotImage1,
    'large_screenshot_image2': largeScreenshotImage2,
    'large_screenshot_image3': largeScreenshotImage3,
    'cast': cast?.map((e) => e.toJson()).toList(),
    'torrents': torrents?.map((e) => e.toJson()).toList(),
    'date_uploaded': dateUploaded,
    'date_uploaded_unix': dateUploadedUnix,
  };
}
