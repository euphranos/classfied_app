// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String userId;
  final String userName;
  String userPhoto;
  final String userEmail;
  final String userPassword;

  UserModel(this.userId, this.userName, this.userPhoto, this.userEmail,
      this.userPassword);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'userPhoto': userPhoto,
      'userEmail': userEmail,
      'userPassword': userPassword,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['userId'] as String,
      map['userName'] as String,
      map['userPhoto'] as String,
      map['userEmail'] as String,
      map['userPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
