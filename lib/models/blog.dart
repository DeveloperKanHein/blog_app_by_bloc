import 'package:json_annotation/json_annotation.dart';

part 'blog.g.dart';

@JsonSerializable()
class Blog
{
  final String title;
  final String body;
  final String image;
  final String author;
  final String avatar;
  final String date;
  const Blog({ required this.title, required this.body, required this.image, required this.author, required this.avatar,  required this.date });
  factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);
  Map<String, dynamic> toJson() => _$BlogToJson(this);

}