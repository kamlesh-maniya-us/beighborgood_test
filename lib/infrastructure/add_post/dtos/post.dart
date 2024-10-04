// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:neighborgood/infrastructure/add_post/dtos/users.dart';

class Post {
  final String title;
  final String description;
  final String imgUrl;
  final Users user;

  Post({
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.user,
  });

  Post copyWith({
    String? title,
    String? description,
    String? imgUrl,
    Users? user,
  }) {
    return Post(
      title: title ?? this.title,
      description: description ?? this.description,
      imgUrl: imgUrl ?? this.imgUrl,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'imgUrl': imgUrl,
      'user': user.toMap(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      title: map['title'] as String,
      description: map['description'] as String,
      imgUrl: map['image'] as String,
      user: map['user'] != null
          ? Users.fromMap(map['user'] as Map<String, dynamic>)
          : Users(name: "", photoURL: ""),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(title: $title, description: $description, imgUrl: $imgUrl, user: $user)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.imgUrl == imgUrl &&
        other.user == user;
  }

  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode ^ imgUrl.hashCode ^ user.hashCode;
  }
}
