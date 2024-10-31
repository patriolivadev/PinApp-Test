import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp/core/services/dependencies_service.dart';
import 'package:pinapp/features/comment/domain/entities/comment.dart';
import 'package:pinapp/features/comment/presentation/manager/comment_bloc.dart';
import 'package:pinapp/features/post/data/data_sources/post_local_data_source.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';

class CommentPage extends StatefulWidget {
  final Post post;

  const CommentPage({
    super.key,
    required this.post,
  });

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final CommentBloc bloc = getIt<CommentBloc>();
  final PostLocalDataSourceBase localDataSourceBase =
      getIt<PostLocalDataSourceBase>();

  List<Comment>? comments;

  @override
  void initState() {
    bloc.add(ActionGetCommentById(id: widget.post.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
        bloc: bloc,
        listener: listener,
        builder: builder,
      ),
    );
  }

  void listener(context, state) {
    switch (state.runtimeType) {
      case const (OnGetCommentsById):
        comments = (state as OnGetCommentsById).comments;
        print(comments!.length);
      case const (OnGetCommentByIdFailure):
        onGetCommentsFailure(context);
    }
  }

  void onGetCommentsFailure(context) {
    SnackBar snackBar = const SnackBar(
      content: Text('No se pudieron obtener los comentarios!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget builder(context, state) {
    if (comments == null || state is OnLoadingComments) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return buildBody();
  }

  Widget buildBody() {
    return Container();
  }
}
