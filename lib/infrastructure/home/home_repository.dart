import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborgood/_core/constant/app_constant.dart';
import 'package:neighborgood/domain/home/i_home_repository.dart';
import 'package:neighborgood/infrastructure/add_post/dtos/post.dart';
import 'package:neighborgood/infrastructure/add_post/dtos/users.dart';

import '../../domain/_core/failure.dart';

@LazySingleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  final FirebaseFirestore _fireStore;

  HomeRepository(this._fireStore);
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (isConnected) {
      try {
        var posts = await _fireStore
            .collection('posts')
            .orderBy(
              'created_at',
              descending: true,
            )
            .get();
        List<Post> postCollection = [];

        for (final post in posts.docs) {
          DocumentSnapshot userDoc =
              await _fireStore.collection('users').doc(post.data()["userId"]).get();
          postCollection.add(
            Post(
              title: post["title"],
              description: post["description"],
              imgUrl: post["image"],
              user: Users.fromMap(jsonDecode(jsonEncode(userDoc.data()))),
            ),
          );
        }

        return right(postCollection);
      } catch (e) {
        return left(ServerError());
      }
    } else {
      return left(NetworkError());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getMyPosts() async {
    if (isConnected) {
      try {
        var posts = await _fireStore
            .collection('posts')
            .where("userId", isEqualTo: currentUser.userId)
            .orderBy(
              'created_at',
              descending: true,
            )
            .get();

        final postCollection = posts.docs.map(
          (e) {
            Map<String, dynamic> map = e.data();
            map.update('created_at', (value) => "");
            return Post.fromMap(map);
          },
        ).toList();

        return right(postCollection);
      } catch (e) {
        return left(ServerError());
      }
    } else {
      return left(NetworkError());
    }
  }
}
