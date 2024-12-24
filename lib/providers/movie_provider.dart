import 'dart:convert';
import 'package:consapppro/model/movie_model/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

// MovieProvider: Cung cấp dữ liệu phim
class MovieProvider extends StateNotifier<List<Movie>> {
  MovieProvider() : super([]);

  // Phương thức tải dữ liệu phim từ JSON
  Future<void> fetchMovies() async {
    final String response = await rootBundle.loadString('assets/data/movie.json');
    final List<dynamic> data = jsonDecode(response);

    state = data.map((movie) => Movie.fromJson(movie)).toList();
  }
}

// HoverStateNotifier: Cung cấp trạng thái hover cho từng phần tử
class HoverStateNotifier extends StateNotifier<Map<int, bool>> {
  HoverStateNotifier() : super({});

  // Phương thức cập nhật trạng thái hover
  void stateHover(int index, bool isHovering) {
    state = {
      ...state,
      index: isHovering,
    };
  }
}

// Cung cấp MovieProvider qua Riverpod
final movieProvider = StateNotifierProvider<MovieProvider, List<Movie>>((ref) {
  return MovieProvider();
});

// Cung cấp HoverStateNotifier qua Riverpod
final hoverStateProvider = StateNotifierProvider<HoverStateNotifier, Map<int, bool>>(
  (ref) => HoverStateNotifier(),
);
