import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ws_example/application/injection.dart';
import 'package:ws_example/presentation/bloc/content_bloc.dart';
import 'package:ws_example/presentation/main_screen.dart';

class NyanCatApp extends StatelessWidget {
  const NyanCatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<ContentBloc>(),
      child: const MaterialApp(
        title: 'Nyan cat',
        home: MainScreen(),
      ),
    );
  }
}
