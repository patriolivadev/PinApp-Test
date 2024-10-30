import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pinapp/core/services/dependencies_service.dart';
import 'package:pinapp/features/post/domain/entities/post.dart';
import 'package:pinapp/features/post/presentation/manager/post_bloc.dart';
import 'package:pinapp/features/post/presentation/widgets/post_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        posts = (state as OnGetPosts).posts;
      case const (OnGetPostsFailure):
    }
  }

  void onGetPostFailure(context) {
    SnackBar snackBar = const SnackBar(
      content: Text('No se pudieron obtener los posts!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget builder(context, state) {
    print(state.runtimeType);
    if (state is OnLoading || posts == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return buildBody();
  }

  Widget buildBody() {
    return ListView.builder(
      itemCount: posts!.length,
      itemBuilder: (context, index) {
        return PostWidget(
          title: posts![index].title,
          body: posts![index].body,
          liked: posts![index].liked,
          onLikePressed: () {
            setState(() {
              posts![index].liked = !posts![index].liked;
            });
          },
          onCommentsPressed: () {
            // Acción para el botón de comentarios
          },
        );
      },
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
}
