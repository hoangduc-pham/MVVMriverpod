import 'package:consapppro/view_model/movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListMovie extends ConsumerStatefulWidget {
  const ListMovie({super.key});

  @override
  _ListMovieState createState() => _ListMovieState();
}

class _ListMovieState extends ConsumerState<ListMovie> {
  final FocusNode _focusNode = FocusNode();
  late ListMovieViewModel viewModel;
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    viewModel = ListMovieViewModel(ref);
    viewModel.loadMovies();
    _focusNode.requestFocus();
  }
  

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      setState(() {
        if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          if (_selectedIndex < viewModel.movies.length - 1) {
            _updateItemState(_selectedIndex, false);
            _selectedIndex++;
            _updateItemState(_selectedIndex, true);
            _scrollIfNeeded(_selectedIndex);
          }
        } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          if (_selectedIndex > 0) {
            _updateItemState(_selectedIndex, false);
            _selectedIndex--;
            _updateItemState(_selectedIndex, true);
            _scrollIfNeeded(_selectedIndex);
          }
        }
      });
    }
  }

  void _updateItemState(int index, bool isFocusedOrHovered) {
    viewModel.setHover(index, isFocusedOrHovered);
  }

  void _scrollIfNeeded(int index) {
    const double itemWidth = 220.0;
    final double scrollOffset = _scrollController.offset;
    final double viewportWidth = _scrollController.position.viewportDimension;

    final double itemPosition = index * itemWidth;

    if (itemPosition < scrollOffset) {
      _scrollController.animateTo(
        itemPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (itemPosition + itemWidth > scrollOffset + viewportWidth) {
      _scrollController.animateTo(
        itemPosition + itemWidth - viewportWidth,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ListMovieViewModel(ref);
    final movies = viewModel.movies;
    final itemState = viewModel.hoverState;

    if (movies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      autofocus: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, top: 16),
        child: MouseRegion(
           onHover: (event) {
           viewModel.handleHover(
            context: context,
            pointerPosition: event.position,
            scrollController: _scrollController,
          );
        },
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = movies[index];
                final isActive = itemState[index] ?? false;
          
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MouseRegion(
                    onEnter: (_) {
                      _updateItemState(index, true);
                    },
                    onExit: (_) {
                      if (index != _selectedIndex) {
                        _updateItemState(index, false);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: isActive
                            ? Border.all(color: Colors.white, width: 4)
                            : null,
                      ),
                      child: Image.asset(movie.poster),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
