import 'package:flutter/material.dart';
import 'package:ws_example/presentation/main_screen.dart';

class NyanCatApp extends StatelessWidget {
  const NyanCatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Nyan cat',
      home: MainScreen(),
    );
  }
}
