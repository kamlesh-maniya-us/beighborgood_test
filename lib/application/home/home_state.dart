part of 'home_bloc.dart';

class HomeState {
  final Option<Either<Failure, Unit>> failureOrSuccess;
  final bool isFetchingPosts;
  final bool isFetchingMyPosts;
  final List<Post> postCollection;
  final List<Post> myPostCollection;
  final int selectedTabIndex;

  HomeState({
    required this.failureOrSuccess,
    required this.isFetchingPosts,
    required this.postCollection,
    required this.myPostCollection,
    required this.isFetchingMyPosts,
    required this.selectedTabIndex,
  });

  factory HomeState.initial() => HomeState(
        failureOrSuccess: none(),
        isFetchingPosts: false,
        postCollection: [],
        myPostCollection: [],
        isFetchingMyPosts: false,
        selectedTabIndex: 0,
      );

  HomeState copyWith({
    Option<Either<Failure, Unit>>? failureOrSuccess,
    bool? isFetchingPosts,
    bool? isFetchingMyPosts,
    List<Post>? postCollection,
    List<Post>? myPostCollection,
    int? selectedTabIndex,
  }) {
    return HomeState(
      failureOrSuccess: failureOrSuccess ?? this.failureOrSuccess,
      isFetchingPosts: isFetchingPosts ?? this.isFetchingPosts,
      postCollection: postCollection ?? this.postCollection,
      myPostCollection: myPostCollection ?? this.myPostCollection,
      isFetchingMyPosts: isFetchingMyPosts ?? this.isFetchingMyPosts,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }
}
