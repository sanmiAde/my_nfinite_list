import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:my_nfinite_list/data/local/PostModel.dart';
import 'package:my_nfinite_list/data/network/service/post_api_service.dart';

class PostRepository {
  PostApiService postApiService;

  PostRepository() {
    postApiService = PostApiService.create();
  }

  Future<Either<String, List<PostModel>>> getPosts() async {
    Response<List<PostModel>> response = await postApiService.getPosts();

    if (response.isSuccessful) {
      return Right(response.body);
    } else {
      return Left(response.error.toString());
    }
  }

  Future<Response<PostModel>> getPost(int id) {
    return postApiService.getPost(id);
  }
}
