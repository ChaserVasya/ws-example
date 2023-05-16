import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ws_example/domain/content.dart';
import 'package:ws_example/presentation/bloc/content_bloc.dart';

class ContentCell extends StatefulWidget {
  final Content content;

  const ContentCell(this.content, {Key? key}) : super(key: key);

  @override
  State<ContentCell> createState() => _ContentCellState();
}

class _ContentCellState extends State<ContentCell> {
  late final controller = TextEditingController(text: widget.content.body);

  @override
  void didUpdateWidget(covariant ContentCell oldWidget) {
    controller.text = widget.content.body;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: Border.all(color: Colors.black54),
      ),
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onSubmitted: (newBody) {
          final bloc = context.read<ContentBloc>();
          final event = ContentEvent.entered(
            widget.content.copyWith(body: newBody),
          );
          bloc.add(event);
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
