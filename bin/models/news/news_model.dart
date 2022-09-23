class NewsModel {
  final int? id;
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

  factory NewsModel.fromMap(Map map) {
    return NewsModel(
      id: map['id'] ?? '',
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      publishDate: DateTime.fromMicrosecondsSinceEpoch(map['publishDate']),
      updateDate: (map['updateDate'] != null)
          ? DateTime.fromMicrosecondsSinceEpoch(map['updateDate'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
