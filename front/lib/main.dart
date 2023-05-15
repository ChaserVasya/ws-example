import 'package:flutter/cupertino.dart';
import 'package:ws_example/application/app.dart';
import 'package:ws_example/application/injection.config.dart';
import 'package:ws_example/application/injection.dart';

void main() async {
  getIt.init();
  runApp(const NyanCatApp());
}
