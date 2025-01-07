import 'package:consapppro/providers/app_provider.dart';
import 'package:consapppro/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListApp extends ConsumerStatefulWidget {
  const ListApp({super.key});

  @override
  _ListAppState createState() => _ListAppState();
}

class _ListAppState extends ConsumerState<ListApp> {
  late ListAppViewModel viewModel;

  // @override
  // void initState() {
  //   super.initState();
  //   viewModel = ListAppViewModel(ref);
  //   viewModel.loadApps();
  // }

  @override
  Widget build(BuildContext context) {
  final state = ref.watch(appProvider); // Lấy trạng thái hiện tại
    final viewModel = ref.read(appProvider.notifier); // Lấy ViewModel
    final ScrollController scrollController = ScrollController();
    if (state.apps.isEmpty) {
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
            scrollController: scrollController,
          );
        },
        child: SizedBox(
          height: 90,
          child: ListView.builder(
            controller: scrollController,
            itemCount: state.apps.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final app = state.apps[index];
              final isHovering = state.hoverState[index] ?? false;
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
