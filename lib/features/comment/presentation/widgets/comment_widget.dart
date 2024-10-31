import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  final String email;
  final String name;
  final String body;
  final VoidCallback? onLikePressed;

  const CommentWidget({
    super.key,
    required this.email,
    required this.name,
    required this.body,
    this.onLikePressed,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildName,
          buildEmail,
          const SizedBox(height: 8),
          buildBody,
        ],
      ),
    );
  }

  Text get buildName {
    return Text(
      widget.name,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Text get buildEmail {
    return Text(
      widget.email,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
    );
  }

  Text get buildBody {
    return Text(
      widget.body,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
    );
  }
}
