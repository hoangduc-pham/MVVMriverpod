import 'package:consapppro/providers/movie_provider.dart';
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
    late ListMovieViewModel viewModel;
  // @override
  // void initState() {
  //   super.initState();
  //   viewModel = ListMovieViewModel(ref);
  //   viewModel.loadMovies();
  //   _focusNode.requestFocus();
  // }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(movieProvider); // Lấy trạng thái hiện tại
    final viewModel = ref.read(movieProvider.notifier); // Lấy ViewModel
    final FocusNode focusNode = FocusNode();
    final ScrollController scrollController = ScrollController();

    if (state.movies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: (event) => viewModel.handleKeyEvent(event, scrollController),
      autofocus: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, top: 16),
        child: MouseRegion(
          onHover: (event) {
            viewModel.handleHover(
              context: context,
              pointerPosition: event.position,
              scrollController: scrollController,
            );
          },
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              controller: scrollController,
              itemCount: state.movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                final isActive = state.hoverState[index] ?? false;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MouseRegion(
                    onEnter: (_) {
                      viewModel.updateItemState(index, true);
                    },
                    onExit: (_) {
                      viewModel.updateItemState(index, false);
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
