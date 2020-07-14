// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$PostApiService extends PostApiService {
  _$PostApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PostApiService;

  @override
  Future<Response<List<PostModel>>> getPosts() {
    final $url = 'https://jsonplaceholder.typicode.com/posts';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<PostModel>, PostModel>($request);
  }

  @override
  Future<Response<PostModel>> getPost(int id) {
    final $url = 'https://jsonplaceholder.typicode.com/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<PostModel, PostModel>($request);
  }

  @override
  Future<Response<dynamic>> postPost(PostModel post) {
    final $url = 'https://jsonplaceholder.typicode.com';
    final $body = post;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
