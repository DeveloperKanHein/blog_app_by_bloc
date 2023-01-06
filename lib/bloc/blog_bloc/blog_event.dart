part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable
{
  @override
  List<Object> get props => [];
}

class GetBlogList extends BlogEvent
{
  //
}

class AddBlog extends BlogEvent
{
  final Blog blog;
  AddBlog({ required this.blog });
}