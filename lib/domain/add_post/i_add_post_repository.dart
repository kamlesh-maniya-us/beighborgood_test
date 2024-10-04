
import 'package:dartz/dartz.dart';
import 'package:neighborgood/domain/_core/failure.dart';

abstract class IAddPostRepository {
   Future<Either<Failure,Unit>> createPost({
    required String title,
    required String description,
    required String imgPath,
   });
}
