import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_nfinite_list/data/local/PostModel.dart';
import 'package:my_nfinite_list/data/network/PostRepository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository;

  PostBloc(PostState initialState) : super(initialState) {
    postRepository = PostRepository();
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    if (event is PostFetched && !_hasReachedMax(currentState)) {
      if (currentState is PostInitial) {
        final response = await postRepository.getPosts();

        // response.fold((l) => yeildError(), (r) => yeildPostModelLis(r));

        if (response.isRight()) {
          List<PostModel> listOfpost = response.getOrElse(null);
          yield PostSuccess(posts: listOfpost, hasReachedMax: false);
        } else {
          yield PostFailure();
        }
      }
    }
  }
//
//  Stream yeildError() async* {
//    yield PostFailure();
//  }
//
//  void yeildPostModelLis(List<PostModel> listOfpost) async* {
//    yield PostSuccess(posts: listOfpost, hasReachedMax: false);
//  }

  bool _hasReachedMax(PostState state) =>
      state is PostSuccess && state.hasReachedMax;
}
