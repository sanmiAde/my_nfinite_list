// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return PostModel(
    id: json['id'] as int,
    userId: json['userId'] as int,
    title: json['title'] as String,
    body: json['body'] as String,
  );
}

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
