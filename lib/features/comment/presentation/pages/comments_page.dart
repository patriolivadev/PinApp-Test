import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp/core/services/dependencies_service.dart';
import 'package:pinapp/features/comment/domain/entities/comment.dart';
import 'package:pinapp/features/comment/presentation/manager/comment_bloc.dart';
import 'package:pinapp/features/comment/presentation/widgets/comment_widget.dart';
import 'package:pinapp/features/post/data/data_sources/post_local_data_source.dart';
import 'package:pinapp/features/post/presentation/manager/post_bloc.dart';

class CommentPage extends StatefulWidget {
  final int postIndex;

  const CommentPage({
    super.key,
    required this.postIndex,
  });

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final CommentBloc commentBloc = getIt<CommentBloc>();
  final PostBloc postBloc = getIt<PostBloc>();

  final PostLocalDataSourceBase localDataSourceBase =
      getIt<PostLocalDataSourceBase>();

  List<Comment>? comments;

  @override
  void initState() {
    commentBloc
        .add(ActionGetCommentById(id: postBloc.posts![widget.postIndex].id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: draggableBuilder,
    );
  }

  Widget draggableBuilder(
      BuildContext context, ScrollController scrollController) {
    return BlocConsumer(
      bloc: commentBloc,
      listener: listener,
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: builder(context, state, scrollController),
        );
      },
    );
  }

  void listener(context, state) {
    switch (state.runtimeType) {
      case const (OnGetCommentsById):
        comments = (state as OnGetCommentsById).comments;
        break;
      case const (OnGetCommentByIdFailure):
        onGetCommentsFailure(context);
        break;
    }
  }

  void onGetCommentsFailure(context) {
    SnackBar snackBar = const SnackBar(
      content: Text('No se pudieron obtener los comentarios!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget builder(context, state, ScrollController scrollController) {
    if (comments == null || state is OnLoadingComments) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return buildBody(scrollController);
  }

  Widget buildBody(ScrollController scrollController) {
    return Column(
      children: [
        buildHeader(),
        const Divider(),
        buildCommentsList(scrollController),
      ],
    );
  }

  Stack buildHeader() {
    return Stack(
      children: [
        const Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: Icon(Icons.drag_handle),
                ),
              ),
              Center(
                child: Text(
                  'Comentarios',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 40, top: 25),
              child: buildLikeButton,
            ),
          ],
        ),
      ],
    );
  }

  Expanded buildCommentsList(ScrollController scrollController) {
    return Expanded(
      child: ListView.separated(
        controller: scrollController,
        itemCount: comments!.length,
        itemBuilder: itemBuilder,
        separatorBuilder: (context, index) => const Divider(
          thickness: 0.3,
        ),
      ),
    );
  }

  Widget? itemBuilder(context, index) {
    final comment = comments![index];
    return CommentWidget(
      email: comment.email,
      name: comment.name,
      body: comment.body,
    );
  }

  Widget get buildLikeButton {
    return InkWell(
      onTap: () {
        setState(() {
          postBloc.add(ToggleLike(index: widget.postIndex));
        });
      },
      overlayColor: WidgetStateColor.transparent,
      radius: 100,
      child: Row(
        children: [
          Icon(
            postBloc.posts![widget.postIndex].liked
                ? Icons.favorite
                : Icons.favorite_border,
            color: postBloc.posts![widget.postIndex].liked
                ? Colors.red
                : Colors.grey,
            size: 25,
          ),
        ],
      ),
    );
  }
}
