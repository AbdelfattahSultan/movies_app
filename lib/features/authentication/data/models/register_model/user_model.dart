import 'package:movies_app/features/authentication/domain/entity/auth_entity.dart';

class UserModel {
  String? email;
  String? password;
  String? name;
  String? phone;
  int? avaterId;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserModel({
    this.email,
    this.password,
    this.name,
    this.phone,
    this.avaterId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json['email'] as String?,
    password: json['password'] as String?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    avaterId: json['avaterId'] as int?,
    id: json['_id'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    v: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    'phone': phone,
    'avaterId': avaterId,
    '_id': id,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };

  AuthEntity toEntity() {
    return AuthEntity(
      email: email ?? "",
      name: name ?? "",
      phone: phone ?? "",
      avatarId: avaterId ?? 1,
    );
  }
}
