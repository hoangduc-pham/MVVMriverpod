class App {
  final int id;
  final String title;
  final String icon;

  App({
    required this.id,
    required this.title,
    required this.icon,
  });

  factory App.fromJson(Map<String, dynamic> json) {
    return App(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
    );
  }
}
