class Cast {
  String? name;
  String? characterName;
  String? urlSmallImage;
  String? imdbCode;

  Cast({this.name, this.characterName, this.urlSmallImage, this.imdbCode});

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    name: json['name'] as String?,
    characterName: json['character_name'] as String?,
    urlSmallImage: json['url_small_image'] as String?,
    imdbCode: json['imdb_code'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'character_name': characterName,
    'url_small_image': urlSmallImage,
    'imdb_code': imdbCode,
  };
}
