import 'package:blog_app_by_bloc/models/blog.dart';
import 'package:blog_app_by_bloc/widgets/loading_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blog_bloc/blog_bloc.dart';
import 'blog_detail_screen.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({Key? key}) : super(key: key);

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  final BlogBloc _bloc = BlogBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetBlogList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BLOC Pattern"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocProvider(
                  create: (_) => _bloc,
                  child: BlocListener<BlogBloc, BlogState>(
                    listener: (context, state) {
                      if (state is BlogUploading) {
                        showLoading(context: context);
                      } else if (state is BlogUploaded) {
                        Navigator.pop(context);
                      }
                    },
                    child: BlocBuilder<BlogBloc, BlogState>(
                      builder: (context, state) {
                        if (state is BlogLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is BlogSuccess) {
                          return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              itemCount: state.blogList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlogDetailScreen(
                                                        blog: state
                                                            .blogList[index])));
                                      },
                                      title: Text(state.blogList[index].title),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Text(
                                          "- by ${state.blogList[index].author}",
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      )),
                                );
                              });
                        } else if (state is BlogEmpty) {
                          return const Center(
                            child: Text("Data Empty"),
                          );
                        } else if (state is BlogError) {
                          return const Center(
                            child: Text("Loading Error"),
                          );
                        }
                        return Container();
                      },
                    ),
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bloc.add(
            AddBlog(
              blog: const Blog(
                  title:
                      "In inventore occaecati sint sed sunt aut maiores aut.",
                  body:
                      "Est ea quia modi reiciendis architecto quas. Dignissimos quasi tempora. Dolor voluptatem aut ut error fuga dolorum quis.",
                  image: "http://loremflickr.com/640/480",
                  author: "Kan Hein",
                  avatar:
                      "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/757.jpg",
                  date: "2022-10-20T11:01:01.004Z"),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
