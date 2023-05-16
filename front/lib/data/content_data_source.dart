import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:ws_example/domain/content.dart';

@injectable
class ContentDataSource {
  static const _timeout = Duration(seconds: 3);
  static final _uri = Uri.parse('ws://0.0.0.0:8081/ws');
  late WebSocketChannel _channel;

  Future<Stream<List<Content>>> connect() async {
    _channel = WebSocketChannel.connect(_uri);
    await _ensureConnected();
    return _channel.stream.map((event) {
      final json1 = jsonDecode(event) as List<dynamic>;
      final json2 = json1.cast<Map<String, dynamic>>();
      return json2.map(Content.fromJson).toList();
    });
  }

  Future<void> sendContent(List<Content> contents) async {
    await _ensureConnected();
    final data = jsonEncode(contents.map((e) => e.toJson()).toList());
    return _channel.sink.add(data);
  }

  Future<void> _ensureConnected() async {
    await _channel.ready.timeout(
      _timeout,
      onTimeout: () => throw Exception('Соединение не установлено до таймаута'),
    );
  }
}
