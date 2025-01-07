import 'dart:convert';
import 'package:consapppro/model/app_model/app.dart';
import 'package:consapppro/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

final appProvider =
    StateNotifierProvider<ListAppNotifier, ListAppViewModel>((ref) {
  return ListAppNotifier();
}); 

class ListAppNotifier extends StateNotifier<ListAppViewModel> {
  ListAppNotifier() : super(const ListAppViewModel()) {
    _init(); // Tải dữ liệu ban đầu
  }

  // Hàm khởi tạo trạng thái ban đầu
  Future<void> _init() async {
    await fetchApps();
  }

  // Tải dữ liệu từ file JSON
  Future<void> fetchApps() async {
    final String response = await rootBundle.loadString('assets/data/app.json');
    final List<dynamic> data = jsonDecode(response);
    final apps = data.map((app) => App.fromJson(app)).toList();
    state = state.copyWith(apps: apps);
  }

  // Cập nhật trạng thái hover cho từng mục
  void setHover(int index, bool isHovering) {
    final updatedHoverState = Map<int, bool>.from(state.hoverState)
      ..[index] = isHovering;
    state = state.copyWith(hoverState: updatedHoverState);
  }

  // Xử lý hover để cuộn danh sách
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
