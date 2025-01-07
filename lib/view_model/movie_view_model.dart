import 'package:consapppro/model/movie_model/movie.dart';
import 'package:equatable/equatable.dart';

class ListMovieViewModel extends Equatable {
  final List<Movie> movies;
  final Map<int, bool> hoverState;
  final int selectedIndex;


  const ListMovieViewModel({
    this.movies = const [],
    this.hoverState = const {},
    this.selectedIndex = 0,
  });
  
  ListMovieViewModel copyWith({
    List<Movie>? movies,
    Map<int, bool>? hoverState,
    int? selectedIndex,
  }) {
    return ListMovieViewModel(
      movies: movies ?? this.movies,
      hoverState: hoverState ?? this.hoverState,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [movies, hoverState, selectedIndex];
}
