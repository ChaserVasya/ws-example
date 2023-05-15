import 'package:flutter/material.dart';
import 'package:ws_example/domain/content.dart';

class ContentCell extends StatelessWidget {
  final Content content;

  const ContentCell(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: Border.all(color: Colors.black54),
      ),
      padding: const EdgeInsets.all(16),
      child: Text(content.body),
    );
  }
}
