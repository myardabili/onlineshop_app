import 'dart:convert';

class RegisterModel {
  final String? accessToken;
  final User? user;

  RegisterModel({
    this.accessToken,
    this.user,
  });

  factory RegisterModel.fromJson(String str) =>
      RegisterModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromMap(Map<String, dynamic> json) => RegisterModel(
        accessToken: json["access_token"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "user": user?.toMap(),
      };
}

class User {
  final String? name;
  final String? email;
  final String? phone;
  final String? roles;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  User({
    this.name,
    this.email,
    this.phone,
    this.roles,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        roles: json["roles"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "phone": phone,
        "roles": roles,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
