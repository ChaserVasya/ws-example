import 'package:web_socket_channel/web_socket_channel.dart';

/// Local test of server ws connection. Should
void main() async {
  final uri = Uri.parse('ws://localhost:8081/ws');
  final channel = WebSocketChannel.connect(uri);

  channel.stream.listen(print);

  await Future.delayed(const Duration(seconds: 10));
  print('closing');
  channel.sink.close();
}
