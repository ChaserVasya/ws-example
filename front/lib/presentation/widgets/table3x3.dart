import 'package:flutter/material.dart';

class Table3x3 extends StatelessWidget {
  final List<Widget> children;

  const Table3x3({
    super.key,
    required this.children,
  }) : assert(children.length == 9);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          TableCell(child: children[0]),
          TableCell(child: children[1]),
          TableCell(child: children[2]),
        ]),
        TableRow(children: [
          TableCell(child: children[3]),
          TableCell(child: children[4]),
          TableCell(child: children[5]),
        ]),
        TableRow(children: [
          TableCell(child: children[6]),
          TableCell(child: children[7]),
          TableCell(child: children[8]),
        ]),
      ],
    );
  }
}
