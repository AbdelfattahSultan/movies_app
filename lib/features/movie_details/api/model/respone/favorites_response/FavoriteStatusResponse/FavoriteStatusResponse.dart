class FavoriteStatusResponse {
  final bool isFavorite;

  FavoriteStatusResponse({required this.isFavorite});

  factory FavoriteStatusResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteStatusResponse(
      isFavorite: json["data"] ?? false,
    );
  }
}
