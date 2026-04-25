import 'package:readify_app/features/auth/domain/entities/User.dart';

class UserModel extends User {
  final String token;

  UserModel({
    required this.token,
  }) : super(token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}