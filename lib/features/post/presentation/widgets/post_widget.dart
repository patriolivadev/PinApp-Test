import 'package:flutter/material.dart';
import 'package:pinapp/core/services/dependencies_service.dart';
import 'package:pinapp/features/post/presentation/manager/post_bloc.dart';

class PostWidget extends StatefulWidget {
  final int postIndex;
  final String title;
  final String body;
  final bool liked;
  final VoidCallback? onLikePressed;
  final VoidCallback? onCommentsPressed;

  const PostWidget({
    super.key,
    required this.title,
    required this.body,
    this.liked = false,
    this.onLikePressed,
    this.onCommentsPressed,
    required this.postIndex,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final PostBloc postBloc = getIt<PostBloc>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: widget.onCommentsPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle,
                const SizedBox(height: 8),
                buildBody,
                const SizedBox(height: 16),
                buildActions,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row get buildActions {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildLikeButton,
      ],
    );
  }

  Widget get buildLikeButton {
    return InkWell(
      onTap: widget.onLikePressed,
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
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            'Me gusta',
            style: TextStyle(
              color: postBloc.posts![widget.postIndex].liked ? Colors.red : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Text get buildBody {
    return Text(
      widget.body,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
    );
  }

  Text get buildTitle {
    return Text(
      widget.title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
