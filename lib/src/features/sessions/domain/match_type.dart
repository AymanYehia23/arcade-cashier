import 'package:freezed_annotation/freezed_annotation.dart';

enum MatchType {
  @JsonValue('single')
  single,
  @JsonValue('multi')
  multi,
  @JsonValue('other')
  other,
}
