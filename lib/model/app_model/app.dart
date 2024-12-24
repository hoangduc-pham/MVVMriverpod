import 'package:freezed_annotation/freezed_annotation.dart';
part 'app.freezed.dart';
part 'app.g.dart'; // Dành cho JSON serialization

@freezed
class App with _$App {
  const factory App({
    required int id,
    required String title,
    required String icon,
  }) = _App;

  factory App.fromJson(Map<String, dynamic> json) => _$AppFromJson(json);
}
// class App {
//   final int id;
//   final String title;
//   final String icon;

//   App({
//     required this.id,
//     required this.title,
//     required this.icon,
//   });

//   factory App.fromJson(Map<String, dynamic> json) {
//     return App(
//       id: json['id'],
//       title: json['title'],
//       icon: json['icon'],
//     );
//   }
// }
