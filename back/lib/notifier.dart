import 'dart:async';

class Notifier<S> {
  final sinks = <StreamSink<S>>[];

  void addListener(StreamSink<S> sink) {
    sink.done.then((_) => sinks.remove(sink));
  }

  void emit(S event) {
    for (final sink in sinks) {
      sink.add(event);
    }
  }
}
