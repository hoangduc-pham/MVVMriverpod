import 'package:freezed_annotation/freezed_annotation.dart';
part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie(
      {required int id,
      required String title,
      required String poster}) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
