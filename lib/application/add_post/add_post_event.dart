part of 'add_post_bloc.dart';

abstract class AddPostEvent {}

class Empty extends AddPostEvent {}

class SelectImage extends AddPostEvent {
  final String image;

  SelectImage({required this.image});
}

class ChangeTitle extends AddPostEvent {
  final String title;

  ChangeTitle({
    required this.title,
  });
}

class ChangeDescription extends AddPostEvent {
  final String description;

  ChangeDescription({
    required this.description,
  });
}

class CreatePost extends AddPostEvent {}
