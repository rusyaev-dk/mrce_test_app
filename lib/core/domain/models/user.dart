import 'package:equatable/equatable.dart';

class User extends Equatable {
  
  const User({
    required this.userId,
    required this.fullName,
    required this.phone,
    required this.languageCode,
    required this.createdAt,
    required this.updatedAt,
    this.isAdmin = false,
  });

  final String userId;
  final String fullName;
  final String phone;
  final String languageCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isAdmin;

factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] as String,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      languageCode: json['language_code'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': userId,
      'full_name': fullName,
      'phone': phone,
      'language_code': languageCode,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => <Object?>[
    userId,
    fullName,
    phone,
    languageCode,
    createdAt,
    updatedAt,
    isAdmin,
  ];
}
