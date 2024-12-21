class Movie {
  final int id;
  final String title;
  final String poster;

  Movie({
    required this.id,
    required this.title,
    required this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      poster: json['poster'],
    );
  }
}
