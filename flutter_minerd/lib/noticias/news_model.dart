// news_model.dart
class News {
  final String title;
  final String link;
  final String content;

  News({required this.title, required this.link, required this.content});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title']['rendered'],
      link: json['link'],
      content: json['content']['rendered'],
    );
  }
}
