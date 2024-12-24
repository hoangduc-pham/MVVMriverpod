import 'package:consapppro/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListApp extends ConsumerStatefulWidget {
  const ListApp({Key? key}) : super(key: key);

  @override
  _ListAppState createState() => _ListAppState();
}

class _ListAppState extends ConsumerState<ListApp> {
  late ListAppViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ListAppViewModel(ref);
    viewModel.loadApps();
  }

  @override
  Widget build(BuildContext context) {
    final apps = viewModel.apps;
    final hoverState = viewModel.hoverState;
    final ScrollController _scrollController = ScrollController();
    if (apps.isEmpty) {
      return const Center(
          child:
              CircularProgressIndicator());
    }
    return Padding(
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
          height: 90,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: apps.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final app = apps[index];
              final isHovering = hoverState[index] ?? false;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MouseRegion(
                  onEnter: (_) {
                    viewModel.setHover(index, true);
                  },
                  onExit: (_) {
                    viewModel.setHover(index, false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: isHovering
                            ? Border.all(color: Colors.white, width: 4)
                            : null,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Image.asset(app.icon),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
