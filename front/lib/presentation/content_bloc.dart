import 'package:bloc/bloc.dart';
import 'package:ws_example/domain/content.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc() : super(ContentStateInitial());
}

abstract class ContentState {}

class ContentStateInitial extends ContentState {}

class ContentStateMain extends ContentState {
  final List<Content> contents;

  ContentStateMain(this.contents);
}

abstract class ContentEvent {}
