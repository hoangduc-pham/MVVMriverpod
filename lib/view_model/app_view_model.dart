import 'package:consapppro/model/app_model/app.dart';
import 'package:equatable/equatable.dart';

class ListAppViewModel extends Equatable {
  final List<App> apps; // Danh sách ứng dụng
  final Map<int, bool> hoverState; // Trạng thái hover của từng mục

  const ListAppViewModel({
    this.apps = const [],
    this.hoverState = const {},
  });

  ListAppViewModel copyWith({
    List<App>? apps,
    Map<int, bool>? hoverState,
  }) {
    return ListAppViewModel(
      apps: apps ?? this.apps,
      hoverState: hoverState ?? this.hoverState,
    );
  }

  @override
  List<Object?> get props => [apps, hoverState];
}
