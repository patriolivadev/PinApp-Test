import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp/core/services/dependencies_service.dart';
import 'package:pinapp/features/comment/presentation/pages/comments_page.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';
import 'package:pinapp/features/post/presentation/manager/post_bloc.dart';
import 'package:pinapp/features/post/presentation/widgets/post_widget.dart';

class PostPage extends StatefulWidget {
  const PostPage({
    super.key,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostBloc bloc = getIt<PostBloc>();

  String name = '';
  String lastName = '';
  bool liked = false;
  List<Post>? posts;

  @override
  void initState() {
    bloc.add(ActionGetPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocConsumer(
        bloc: bloc,
        listener: listener,
        builder: builder,
      ),
    );
  }

  void listener(context, state) {
    switch (state.runtimeType) {
      case const (OnGetPosts):
        bloc.posts = (state as OnGetPosts).posts;
      case const (OnGetPostsFailure):
        onGetPostsFailure(context);
    }
  }

  void onGetPostsFailure(context) {
    SnackBar snackBar = const SnackBar(
      content: Text('No se pudieron obtener los posts!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget builder(context, state) {
    if (state is OnLoading || bloc.posts == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return buildBody();
  }

  Widget buildBody() {
    return ListView.builder(
      itemCount: bloc.posts!.length,
      itemBuilder: itemBuilder,
    );
  }

  Widget? itemBuilder(context, index) {
    return PostWidget(
      title: bloc.posts![index].title,
      body: bloc.posts![index].body,
      liked: bloc.posts![index].liked,
      onLikePressed: () {
        setState(() {
          bloc.add(ToggleLike(index: index));
        });
      },
      onCommentsPressed: () => showCommentsModal(context, index),
      postIndex: index,
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: const Size(40, 40),
      child: Container(
        color: Colors.lightBlueAccent,
        child: const Center(child: Text("APPBAR")),
      ),
    );
  }

  void showCommentsModal(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CommentPage(postIndex: index);
      },
    );
  }
}
