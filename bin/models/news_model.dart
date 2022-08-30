class NewsModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime publishDate;
  final DateTime? updateDate;

  const NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishDate,
    this.updateDate,
  });
}
