import 'package:consapppro/model/app_model/app.dart';
import 'package:consapppro/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListAppViewModel {
  final WidgetRef ref;

  ListAppViewModel(this.ref);
  // Lấy dữ liệu phim từ provider
  List<App> get apps => ref.watch(appProvider);
  // Lấy trạng thái hover từ provider
  Map<int, bool> get hoverState => ref.watch(hoverStateProvider);
  // Hàm tải dữ liệu phim
  Future<void> loadApps() async {
    await ref.read(appProvider.notifier).fetchApps();
  }

  // Hàm cập nhật trạng thái hover
  void setHover(int index, bool isHovering) {
    ref.read(hoverStateProvider.notifier).stateHover(index, isHovering);
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
}
