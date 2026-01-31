import 'package:freezed_annotation/freezed_annotation.dart';

enum DeviceType {
  @JsonValue('PlayStation 4')
  playStation4,
  @JsonValue('PlayStation 5')
  playStation5;

  String get displayTitle {
    switch (this) {
      case DeviceType.playStation4:
        return 'PlayStation 4';
      case DeviceType.playStation5:
        return 'PlayStation 5';
    }
  }

  String get jsonValue {
    switch (this) {
      case DeviceType.playStation4:
        return 'PlayStation 4';
      case DeviceType.playStation5:
        return 'PlayStation 5';
    }
  }
}
