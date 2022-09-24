class NewsModel {
  int? id;
  String? title;
  String? description;
  DateTime? createdDate;
  DateTime? updatedDate;
  int? userId;

  NewsModel();

  factory NewsModel.fromMap(Map map) {
    return NewsModel()
      ..id = map['id']?.toInt()
      ..title = map['titulo']
      ..description = map['descricao'].toString()
      ..createdDate = map['dt_criacao']
      ..updatedDate = map['dt_atualizacao']
      ..userId = map['id_usuario']?.toInt();
  }

  factory NewsModel.fromRequest(Map map) {
    return NewsModel()
      ..id = map['id']?.toInt()
      ..title = map['title']
      ..description = map['description']
      ..userId = map['userId']?.toInt();
  }

  Map toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'NewsModel{id: $id, title: $title, description: $description, createdDate: $createdDate, updatedDate: $updatedDate, userId: $userId}';
  }
}
