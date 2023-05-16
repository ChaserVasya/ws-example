import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ws_example/presentation/bloc/content_bloc.dart';
import 'package:ws_example/presentation/widgets/content_cell.dart';
import 'package:ws_example/presentation/widgets/table3x3.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/logo.png', height: 120),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ContentBloc>().add(const ContentEvent.subscribe());
            },
          ),
        ],
      ),
      body: const MainScreenContent(),
    );
  }
}

class MainScreenContent extends StatelessWidget {
  const MainScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContentBloc, ContentState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (_, message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 7),
            ));
          },
          orElse: () => null,
        );
      },
      builder: (context, state) {
        return state.when<Widget>(
          loading: () {
            return const Center(child: CircularProgressIndicator.adaptive());
          },
          main: (contents) {
            return Table3x3(children: [
              for (final content in contents) ContentCell(content),
            ]);
          },
          error: (contents, _) {
            return Table3x3(children: [
              for (final content in contents) ContentCell(content),
            ]);
          },
        );
      },
    );
  }
}
