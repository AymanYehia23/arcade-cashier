import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../localization/generated/app_localizations.dart';

enum DeviceType {
  @JsonValue('PlayStation 4')
  playStation4,
  @JsonValue('PlayStation 5')
  playStation5;

  String displayTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case DeviceType.playStation4:
        return l10n.playstation4;
      case DeviceType.playStation5:
        return l10n.playstation5;
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
