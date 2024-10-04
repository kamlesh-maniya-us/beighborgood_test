import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborgood/domain/_core/failure.dart';
import 'package:neighborgood/domain/home/i_home_repository.dart';
import 'package:neighborgood/infrastructure/add_post/dtos/post.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeRepository _homeRepository;
  HomeBloc(this._homeRepository) : super(HomeState.initial()) {
    on<HomeEvent>(
      (event, emit) async {
        switch (event) {
          case GetAllPosts e:
            await _onGetAllPosts(e, emit);
            break;
          case GetMyPosts e:
            await _onGetMyPosts(e, emit);
            break;
          case ChangeTabIndex e:
            await _onChangeTabIndex(e, emit);
            break;

          default:
            throw UnimplementedError('Unknown event: $event');
        }
      },
    );
  }

  Future<void> _onGetAllPosts(GetAllPosts e, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      failureOrSuccess: none(),
      isFetchingPosts: true,
    ));
    final result = await _homeRepository.getAllPosts();

    final updatedState = result.fold(
      (l) => state.copyWith(
        failureOrSuccess: optionOf(left(l)),
        isFetchingPosts: false,
      ),
      (r) => state.copyWith(
        failureOrSuccess: none(),
        postCollection: r,
        isFetchingPosts: false,
      ),
    );
    emit(updatedState);
  }

  Future<void> _onGetMyPosts(GetMyPosts e, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      failureOrSuccess: none(),
      isFetchingMyPosts: true,
    ));
    final result = await _homeRepository.getMyPosts();

    final updatedState = result.fold(
      (l) => state.copyWith(
        failureOrSuccess: optionOf(left(l)),
        isFetchingMyPosts: false,
      ),
      (r) => state.copyWith(
        failureOrSuccess: none(),
        myPostCollection: r,
        isFetchingMyPosts: false,
      ),
    );
    emit(updatedState);
  }

  Future<void> _onChangeTabIndex(ChangeTabIndex e, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        selectedTabIndex: e.index,
      ),
    );
  }
}
