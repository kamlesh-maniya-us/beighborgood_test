// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Users {
  final String name;
  final String photoURL;
  final String? userId;

  Users({
    required this.name,
    required this.photoURL,
    this.userId,
  });


  Users copyWith({
    String? name,
    String? photoURL,
    String? userId,
  }) {
    return Users(
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'photoURL': photoURL,
      'userId': userId,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      name: map['name'] as String,
      photoURL: map['photoURL'] as String,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Users(name: $name, photoURL: $photoURL, userId: $userId)';

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.photoURL == photoURL &&
      other.userId == userId;
  }

  @override
  int get hashCode => name.hashCode ^ photoURL.hashCode ^ userId.hashCode;
}
