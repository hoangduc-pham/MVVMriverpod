import 'dart:convert';
import 'package:consapppro/model/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

// AppProvider: Cung cấp dữ liệu phim
class AppProvider extends StateNotifier<List<App>> {
  AppProvider() : super([]);

  // Phương thức tải dữ liệu phim từ JSON
  Future<void> fetchApps() async {
    final String response = await rootBundle.loadString('assets/data/app.json');
    final List<dynamic> data = jsonDecode(response);

    state = data.map((app) => App.fromJson(app)).toList();
  }
}

// HoverStateNotifier: Cung cấp trạng thái hover cho từng phần tử
class HoverStateNotifier extends StateNotifier<Map<int, bool>> {
  HoverStateNotifier() : super({});

  // Phương thức cập nhật trạng thái hover
  void setHover(int index, bool isHovering) {
    state = {
      ...state,
      index: isHovering,
    };
  }
}

// Cung cấp AppProvider qua Riverpod
final appProvider = StateNotifierProvider<AppProvider, List<App>>((ref) {
  return AppProvider();
});

// Cung cấp HoverStateNotifier qua Riverpod
final hoverStateProvider = StateNotifierProvider<HoverStateNotifier, Map<int, bool>>(
  (ref) => HoverStateNotifier(),
);
