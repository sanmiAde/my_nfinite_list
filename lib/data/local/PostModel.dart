import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PostModel.g.dart';

@JsonSerializable()
class PostModel extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  const PostModel({this.id, this.userId, this.title, this.body});

  @override
  List<Object> get props => [id, title, body, userId];

  @override
  String toString() => 'Post { id: $id }';

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
