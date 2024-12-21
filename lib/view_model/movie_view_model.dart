import 'package:consapppro/model/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/movie_provider.dart';

class ListMovieViewModel {
  final WidgetRef ref;

  ListMovieViewModel(this.ref);
 // Lấy dữ liệu phim từ provider
  List<Movie> get movies => ref.watch(movieProvider);
      // Lấy trạng thái hover từ provider
  Map<int, bool> get hoverState => ref.watch(hoverStateProvider);
 // Hàm tải dữ liệu phim
  Future<void> loadMovies() async {
    await ref.read(movieProvider.notifier).fetchMovies();
  }
    // Hàm cập nhật trạng thái hover
  void setHover(int index, bool isHovering) {
    ref.read(hoverStateProvider.notifier).setHover(index, isHovering);
  }
}
