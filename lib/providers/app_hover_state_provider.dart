import 'package:flutter_riverpod/flutter_riverpod.dart';

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

// Cung cấp HoverStateNotifier qua Riverpod
final hoverStateProvider = StateNotifierProvider<HoverStateNotifier, Map<int, bool>>(
  (ref) => HoverStateNotifier(),
);