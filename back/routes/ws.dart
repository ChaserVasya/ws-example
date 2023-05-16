import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:ws_example/content.dart';
import 'package:ws_example/global_state.dart' as global;
import 'package:ws_example/dto_mapper.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler(dtoMapper((channel) {
    _sendCurrentState(channel);
    global.notifier.addListener(channel.sink);
    channel.stream.listen(_refreshEndEmit);
  }));
  return handler(context);
}

void _refreshEndEmit(List<Content> newContents) {
  print('newContent: ${jsonEncode(newContents)}');
  global.contents = newContents;
  global.notifier.emit(global.contents);
}

void _sendCurrentState(StreamChannel<List<Content>> channel) {
  print('sent to new user current: ${jsonEncode(global.contents)}');
  channel.sink.add(global.contents);
}
