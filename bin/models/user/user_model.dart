class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActive;
  DateTime? createdDate;
  DateTime? updatedDate;

  UserModel();

  UserModel.create({
    this.id,
    this.name,
    this.email,
    this.isActive,
    this.createdDate,
    this.updatedDate,
  });

  factory UserModel.fromMap(Map map) {
    return UserModel.create(
      id: map['id']?.toInt() ?? 0,
      name: map['nome'] ?? '',
      email: map['email'] ?? '',
      isActive: map['is_ativo'] == 1,
      createdDate: map['dt_criacao'],
      updatedDate: map['dt_atualizacao'],
    );
  }

  factory UserModel.fromEmail(Map map) {
    return UserModel()
      ..id = map['id']?.toInt()
      ..password = map['senha'];
  }

  factory UserModel.fromRequest(Map map) {
    return UserModel()
      ..name = map['name']
      ..email = map['email']
      ..password = map['password'];
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, isActive: $isActive, createdDate: $createdDate, updatedDate: $updatedDate}';
  }
}
