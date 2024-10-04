part of 'add_post_bloc.dart';

class AddPostState {
  final Option<Either<Failure, Unit>> failureOrSuccess;
  final String selectedFile;
  final String title;
  final String description;
  final bool isCreatingPost;
  final bool isPostCreated;

  AddPostState({
    required this.selectedFile,
    required this.failureOrSuccess,
    required this.title,
    required this.description,
    required this.isCreatingPost,
    required this.isPostCreated,
  });

  factory AddPostState.initial() => AddPostState(
        failureOrSuccess: none(),
        selectedFile: "",
        title: '',
        description: '',
        isCreatingPost: false,
        isPostCreated: false,
      );

  AddPostState copyWith({
    Option<Either<Failure, Unit>>? failureOrSuccess,
    String? selectedFile,
    String? title,
    String? description,
    bool? isCreatingPost,
    bool? isPostCreated,
  }) {
    return AddPostState(
      failureOrSuccess: failureOrSuccess ?? this.failureOrSuccess,
      selectedFile: selectedFile ?? this.selectedFile,
      title: title ?? this.title,
      description: description ?? this.description,
      isCreatingPost: isCreatingPost ?? this.isCreatingPost,
      isPostCreated: isPostCreated ?? this.isPostCreated,
    );
  }
}
