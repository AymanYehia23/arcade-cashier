import 'package:freezed_annotation/freezed_annotation.dart';

enum SessionType {
  @JsonValue('open')
  open,
  @JsonValue('fixed')
  fixed,
}
