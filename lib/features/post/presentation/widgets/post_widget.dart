import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
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
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
    );
  }

  Row get buildActions {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildLikeButton,
        const SizedBox(width: 16),
        buildCommentsButton,
      ],
    );
  }

  Widget get buildLikeButton {
    return GestureDetector(
      onTap: widget.onLikePressed,
      child: Row(
        children: [
          Icon(
            widget.liked ? Icons.favorite : Icons.favorite_border,
            color: widget.liked ? Colors.red : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            'Me gusta',
            style: TextStyle(
              color: widget.liked ? Colors.red : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget get buildCommentsButton {
    return GestureDetector(
      onTap: widget.onCommentsPressed,
      child: const Row(
        children: [
          Icon(
            Icons.chat_bubble_outline,
            color: Colors.black54,
            size: 20,
          ),
          SizedBox(width: 4),
          Text(
            'comentarios',
            style: TextStyle(
              color: Colors.black54,
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
