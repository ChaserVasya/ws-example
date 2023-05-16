import 'package:json_annotation/json_annotation.dart';

part 'content.g.dart';

@JsonSerializable()
class Content {
  Content(this.id, [this.body = '']);

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);

  final int id;
  String body;

  @override
  String toString() {
    return 'Content(id:$id, body: $body)';
  }
}
