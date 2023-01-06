import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../models/blog.dart';
import '../../repository/repositories.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState>
{
  BlogBloc() : super(BlogInitialState())
  {
    final Repositories repositories = Repositories(Dio(BaseOptions(contentType: "application/json")));
    on<GetBlogList>((event, emit) async {
      try{
        emit(BlogLoading());
        final blog = await repositories.getBlog();
        emit(BlogSuccess(blogList: blog));
        if(blog.isEmpty){
          emit(BlogEmpty());
        }
      }catch(e){
        emit(BlogError());
      }
    });

    on<AddBlog>((event, emit) async {
      try{
        emit(BlogUploading());
        await repositories.createBlog(event.blog);
        emit(BlogUploaded());
        final blog = await repositories.getBlog();
        emit(BlogSuccess(blogList: blog));
        if(blog.isEmpty){
          emit(BlogEmpty());
        }
      }catch(e){
        emit(BlogError());
      }
    });
  }
}