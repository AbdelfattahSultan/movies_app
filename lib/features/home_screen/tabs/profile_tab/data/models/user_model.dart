class UserModel {
  final String id;
  final String email;
  final String? password;
  final String name;
  final String phone;
  final int avaterId;
  final String createdAt;
  final String updatedAt;
  final int v;

  UserModel({
    required this.id,
    required this.email,
    this.password,
    required this.name,
    required this.phone,
    required this.avaterId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      password: json['password'],
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      avaterId: json['avaterId'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'avaterId': avaterId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }

  UserModel copyWith({String? name, String? phone, int? avaterId}) {
    return UserModel(
      id: id,
      email: email,
      password: password,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avaterId: avaterId ?? this.avaterId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
    );
  }
}
