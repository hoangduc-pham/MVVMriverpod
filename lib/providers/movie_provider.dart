import 'dart:convert';
import 'package:consapppro/model/movie_model/movie.dart';
import 'package:consapppro/view_model/movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

final movieProvider =
    StateNotifierProvider<ListMovieNotifier, ListMovieViewModel>(
        (ref) => ListMovieNotifier());

class ListMovieNotifier extends StateNotifier<ListMovieViewModel> {
  ListMovieNotifier() : super(const ListMovieViewModel()) {
    _init();
  }

  Future<void> _init() async {
    await fetchMovies();
  }

  Future<void> fetchMovies() async {
    final String response = await rootBundle.loadString('assets/data/movie.json');
    final List<dynamic> data = jsonDecode(response);
    final movies = data.map((movie) => Movie.fromJson(movie)).toList();
    state = state.copyWith(movies: movies);
  }

  void setHover(int index, bool isHovering) {
    final updatedHoverState = Map<int, bool>.from(state.hoverState)
      ..[index] = isHovering;
    state = state.copyWith(hoverState: updatedHoverState);
  }

  void handleHover({
    required BuildContext context,
    required Offset pointerPosition,
    required ScrollController scrollController,
  }) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(pointerPosition);

    if (localPosition.dx >= box.size.width - 50) {
      scrollController.animateTo(
        scrollController.offset + 200,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    } else if (localPosition.dx <= 50) {
      scrollController.animateTo(
        scrollController.offset - 200,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
  }

  void handleKeyEvent(RawKeyEvent event, ScrollController scrollController) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        if (state.selectedIndex < state.movies.length - 1) {
          updateItemState(state.selectedIndex, false);
          state = state.copyWith(selectedIndex: state.selectedIndex + 1);
          updateItemState(state.selectedIndex, true);
          scrollIfNeeded(state.selectedIndex, scrollController);
        }
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        if (state.selectedIndex > 0) {
          updateItemState(state.selectedIndex, false);
          state = state.copyWith(selectedIndex: state.selectedIndex - 1);
          updateItemState(state.selectedIndex, true);
          scrollIfNeeded(state.selectedIndex, scrollController);
        }
      }
    }
  }

  void updateItemState(int index, bool isActive) {
    final updatedHoverState = Map<int, bool>.from(state.hoverState)
      ..[index] = isActive;
    state = state.copyWith(hoverState: updatedHoverState);
  }

  void scrollIfNeeded(int index, ScrollController scrollController) {
    const double itemWidth = 220.0;
    final double scrollOffset = scrollController.offset;
    final double viewportWidth = scrollController.position.viewportDimension;

    final double itemPosition = index * itemWidth;

    if (itemPosition < scrollOffset) {
      scrollController.animateTo(
        itemPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (itemPosition + itemWidth > scrollOffset + viewportWidth) {
      scrollController.animateTo(
        itemPosition + itemWidth - viewportWidth,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
