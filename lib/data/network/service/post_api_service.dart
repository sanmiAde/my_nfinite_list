import 'package:chopper/chopper.dart';
import 'package:my_nfinite_list/data/local/PostModel.dart';
import 'package:my_nfinite_list/utils/JsonToTypeConverter.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class PostApiService extends ChopperService {
  @Get(path: '/posts')
  Future<Response<List<PostModel>>> getPosts();

  @Get(path: '/{id}')
  Future<Response<PostModel>> getPost(@Path('id') int id);

  @Post()
  Future<Response> postPost(@Body() PostModel post);

  static PostApiService create() {
    final client = ChopperClient(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        services: [_$PostApiService()],
        converter: JsonToTypeConverter(
            {PostModel: (jsonData) => PostModel.fromJson(jsonData)}));

    return _$PostApiService(client);
  }
}
