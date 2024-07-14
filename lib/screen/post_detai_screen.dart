import 'package:flutter/material.dart';
import 'package:guinea_pig/services/post_service.dart';

class PostDetaiScreen extends StatefulWidget {
  final String id;
  const PostDetaiScreen({
    super.key,
    required this.id,
  });

  @override
  State<PostDetaiScreen> createState() => _PostDetaiScreenState();
}

class _PostDetaiScreenState extends State<PostDetaiScreen> {
  dynamic _post = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PostService.fetchPost(widget.id).then((value) {
      setState(() {
        _post = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_post['title']),
      ),
      body: Container(
        child: Text(_post['content']),
      ),
    );
  }
}
