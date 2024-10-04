import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborgood/domain/_core/failure.dart';
import 'package:neighborgood/domain/add_post/i_add_post_repository.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

@injectable
class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final IAddPostRepository _addPostRepository;
  AddPostBloc(this._addPostRepository) : super(AddPostState.initial()) {
    on<AddPostEvent>((event, emit) async {
      switch (event) {
        case SelectImage e:
          await _onSelectImage(e, emit);
          break;
        case ChangeTitle e:
          await _onChangeTitle(e, emit);
          break;
        case ChangeDescription e:
          await _onChangeDescription(e, emit);
          break;
        case CreatePost e:
          await _onCreatePost(e, emit);
          break;
        default:
          throw UnimplementedError('Unknown event: $event');
      }
    });
  }

  Future<void> _onSelectImage(SelectImage e, Emitter<AddPostState> emit) async {
    emit(state.copyWith(
      selectedFile: e.image,
      failureOrSuccess: none(),
    ));
  }

  Future<void> _onChangeTitle(ChangeTitle e, Emitter<AddPostState> emit) async {
    emit(
      state.copyWith(
        title: e.title,
        failureOrSuccess: none(),
      ),
    );
  }

  Future<void> _onChangeDescription(ChangeDescription e, Emitter<AddPostState> emit) async {
    emit(
      state.copyWith(
        description: e.description,
        failureOrSuccess: none(),
      ),
    );
  }

  Future<void> _onCreatePost(CreatePost e, Emitter<AddPostState> emit) async {
    emit(state.copyWith(
      isCreatingPost: true,
      failureOrSuccess: none(),
    ));

    final result = await _addPostRepository.createPost(
      title: state.title,
      description: state.description,
      imgPath: state.selectedFile,
    );

    final updatedState = result.fold(
      (l) => state.copyWith(
        failureOrSuccess: optionOf(left(l)),
        isCreatingPost: false,
      ),
      (r) => state.copyWith(
        failureOrSuccess: none(),
        isCreatingPost: false,
        isPostCreated: true,
      ),
    );
    emit(updatedState);
  }
}
