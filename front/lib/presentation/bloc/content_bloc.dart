import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ws_example/data/content_data_source.dart';
import 'package:ws_example/domain/content.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'content_bloc.freezed.dart';

@injectable
class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final ContentDataSource _contentSource;

  ContentBloc(this._contentSource) : super(const ContentState.loading()) {
    on<ContentReceived>(_onReceived, transformer: sequential());
    on<ContentEntered>(_onEntered);
    on<ContentSubscribe>(_onSubscribe);

    add(const ContentEvent.subscribe());
  }

  FutureOr<void> _onReceived(
    ContentReceived event,
    Emitter<ContentState> emit,
  ) {
    emit(ContentState.main(event.contents));
  }

  FutureOr<void> _onEntered(
    ContentEntered event,
    Emitter<ContentState> emit,
  ) async {
    return _exceptionCatcher(emit, () async {
      final newContent = event.newContent;
      var contents = _extractContentsFromState();
      if (contents == null) {
        throw Exception('Ожидается состояние с контентом');
      }
      final newContents = contents.toList();
      newContents[newContent.id] = newContent;
      await _contentSource.sendContent(newContents);
    });
  }

  FutureOr<void> _onSubscribe(
    ContentSubscribe event,
    Emitter<ContentState> emit,
  ) async {
    return _exceptionCatcher(emit, () async {
      emit(const ContentState.loading());
      final stream = await _contentSource.connect();
      final subscription = stream.listen(
        (contents) => add(ContentEvent.received(contents)),
      );
      subscription.onDone(subscription.cancel);
      subscription.onError((_) => subscription.cancel());
    });
  }

  FutureOr<void> _exceptionCatcher<T>(
    Emitter<ContentState> emit,
    FutureOr<void> Function() fn,
  ) async {
    try {
      await fn();
    } catch (e) {
      emit(ContentState.error(
        contents: _extractContentsFromState() ??
            List.generate(9, (i) => Content(id: i, body: '')),
        message: e.toString(),
      ));
    }
  }

  List<Content>? _extractContentsFromState() {
    return state.mapOrNull(
      main: (state) => state.contents,
      error: (state) => state.contents,
    );
  }
}

@freezed
abstract class ContentEvent with _$ContentEvent {
  const factory ContentEvent.subscribe() = ContentSubscribe;
  const factory ContentEvent.entered(
    Content newContent,
  ) = ContentEntered;
  const factory ContentEvent.received(
    List<Content> contents,
  ) = ContentReceived;
}

@freezed
abstract class ContentState with _$ContentState {
  const factory ContentState.loading() = ContentLoading;
  const factory ContentState.main(List<Content> contents) = ContentMain;
  const factory ContentState.error({
    required List<Content> contents,
    required String message,
  }) = ContentError;
}
