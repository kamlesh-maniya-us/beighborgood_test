import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborgood/_core/constant/app_constant.dart';
import 'package:neighborgood/domain/_core/failure.dart';
import 'package:neighborgood/domain/add_post/i_add_post_repository.dart';

@LazySingleton(as: IAddPostRepository)
class AddPostRepository implements IAddPostRepository {
  final FirebaseFirestore _fireStore;
  final FirebaseStorage _firebaseStorage;

  AddPostRepository(this._fireStore, this._firebaseStorage);

  @override
  Future<Either<Failure, Unit>> createPost({
    required String title,
    required String description,
    required String imgPath,
  }) async {
    if (isConnected) {
      try {
        final reference = _firebaseStorage.ref(imgPath.split('/').last);

        final uploadTask = reference.putFile(File(imgPath));

        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        await _fireStore.collection('posts').doc().set({
          "title": title,
          "description": description,
          "image": downloadUrl,
          "userId": currentUser.userId,
          "created_at": FieldValue.serverTimestamp(),
        });

        return right(unit);
      } catch (e) {
        return left(ServerError());
      }
    } else {
      return left(NetworkError());
    }
  }
}
