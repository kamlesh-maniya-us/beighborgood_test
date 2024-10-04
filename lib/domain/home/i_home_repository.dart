import 'package:dartz/dartz.dart';
import 'package:neighborgood/domain/_core/failure.dart';
import 'package:neighborgood/infrastructure/add_post/dtos/post.dart';

abstract class IHomeRepository {
   Future<Either<Failure,List<Post>>> getAllPosts();

   Future<Either<Failure,List<Post>>> getMyPosts();
}
