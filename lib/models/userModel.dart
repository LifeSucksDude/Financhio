import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String uid;
  final String profilePic;

  final String? phoneNumber;
  final String email;
  UserModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    
    this.phoneNumber,
    required this.email,
  });
  
  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
    
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profilePic: map['profilePic']  ??'',
  
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] ?? '' : null,
      email: map['email'] as String,
    );
  }

 
}
