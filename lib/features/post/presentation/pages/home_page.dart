import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinapp/core/services/dependencies_service.dart';
import 'package:pinapp/features/post/presentation/manager/post_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostBloc bloc = getIt<PostBloc>();
  String name = '';
  String lastName = '';

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
    switch (state.runtimeType) {
      case const (OnLoading):
        return const Center(
          child: CircularProgressIndicator(),
        );
      default:
        return buildBody();
    }
  }

  Widget buildBody() {
    return Container();
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
