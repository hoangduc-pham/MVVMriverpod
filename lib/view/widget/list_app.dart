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
    final viewModel = ListAppViewModel(ref);
    final apps = viewModel.apps;
    final hoverState = viewModel.hoverState;
    final ScrollController _scrollController = ScrollController();
    if (apps.isEmpty) {
      return const Center(
          child:
              CircularProgressIndicator()); // Hoặc thông báo "No movies available"
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, top: 16),
      child: MouseRegion(
        onHover: (event) {
          // Lấy vị trí con trỏ chuột và kích thước của danh sách
          final RenderBox box = context.findRenderObject() as RenderBox;
          final Offset localPosition = box.globalToLocal(event.position);

          // Kiểm tra nếu chuột nằm trong góc phải của danh sách
          if (localPosition.dx >= box.size.width - 50) {
            // Cuộn danh sách sang phải
            _scrollController.animateTo(
              _scrollController.offset + 200, // Cuộn thêm 50 pixels
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
            );
          } else if (localPosition.dx <= 50) {
            // Cuộn danh sách sang trái nếu chuột ở góc trái
            _scrollController.animateTo(
              _scrollController.offset - 200, // Cuộn lùi 50 pixels
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
          }
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
