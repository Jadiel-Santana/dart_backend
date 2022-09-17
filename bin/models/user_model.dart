class UserModel {
  final int id;
  final String name;
  final String email;
  final bool isActive;
  final DateTime createdDate;
  final DateTime updatedDate;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
    required this.createdDate,
    required this.updatedDate,
  });

  factory UserModel.fromMap(Map map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      name: map['nome'] ?? '',
      email: map['email'] ?? '',
      isActive: map['is_ativo'] == 1,
      createdDate: map['dt_criacao'],
      updatedDate: map['dt_atualizacao'],
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, isActive: $isActive, createdDate: $createdDate, updatedDate: $updatedDate}';
  }
}
