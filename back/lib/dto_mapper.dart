import 'dart:convert';

import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:ws_example/content.dart';

Function(WebSocketChannel, String?) dtoMapper(
  Function(StreamChannel<List<Content>> channel) handler,
) {
  return (channel, protocol) {
    final transformed = channel.transform(
      StreamChannelTransformer.fromCodec(ContentDTOCodec()),
    );
    handler(transformed);
  };
}

class ContentDTOCodec extends Codec<List<Content>, dynamic> {
  @override
  Converter<List<Content>, dynamic> get encoder => ContentToDTO();

  @override
  Converter<dynamic, List<Content>> get decoder => DTOToContent();
}

class ContentToDTO extends Converter<List<Content>, dynamic> {
  @override
  convert(input) {
    final json = input.map((e) => e.toJson()).toList();
    return jsonEncode(json);
  }

  @override
  startChunkedConversion(output) {
    return output.wrap(convert);
  }
}

class DTOToContent extends Converter<dynamic, List<Content>> {
  @override
  convert(input) {
    final jsonRaw1 = jsonDecode(input);
    final jsonRaw2 = jsonRaw1 as List<dynamic>;
    final json = jsonRaw2.cast<Map<String, dynamic>>();
    return json.map(Content.fromJson).toList();
  }

  @override
  startChunkedConversion(output) {
    return output.wrap(convert);
  }
}

class _WrappedSink<From, To> implements Sink<From> {
  final To Function(From) _transform;
  final Sink<To> _sink;
  _WrappedSink(this._sink, this._transform) {}

  @override
  void add(From data) => _sink.add(_transform(data));

  @override
  void close() => _sink.close();
}

extension SinkMap<To> on Sink<To> {
  Sink<From> wrap<From>(To Function(From) transform) =>
      _WrappedSink(this, transform);
}
