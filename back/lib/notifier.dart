import 'dart:async';

class Notifier<S> {
  final sinks = <StreamSink<S>>[];

  void addListener(StreamSink<S> sink) {
    print('SINK ADD ${sink.hashCode}');
    sinks.add(sink);
    sink.done.then((_) {
      print('SINK DONE ${sink.hashCode}');
      sinks.remove(sink);
    });
    sink.done.onError((error, stackTrace) {
      print('SINK DONE ERROR ${sink.hashCode}');
      sinks.remove(sink);
    });
  }

  void emit(S event) {
    print('EMIT: new event $event');
    print('EMIT: emit to ${sinks.length} sinks');
    for (final sink in sinks) {
      sink.add(event);
    }
  }
}
