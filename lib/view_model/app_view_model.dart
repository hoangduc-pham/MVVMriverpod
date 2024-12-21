import 'package:consapppro/model/app.dart';
import 'package:consapppro/providers/app_provider.dart';
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
    ref.read(hoverStateProvider.notifier).setHover(index, isHovering);
  }
}
