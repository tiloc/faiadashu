import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../../logging/logging.dart';

/// An input formatter for internationalized input of numbers.
class NumericalTextInputFormatter extends TextInputFormatter {
  static final _logger = Logger(NumericalTextInputFormatter);
  final NumberFormat numberFormat;

  NumericalTextInputFormatter(this.numberFormat);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty || newValue.text == oldValue.text) {
      return newValue;
    }

    // Whitespace is otherwise not prevented.
    if (newValue.text.trim() != newValue.text) {
      return oldValue;
    }

    // Group separator is causing lots of trouble. Suppress.
    if (newValue.text.contains(numberFormat.symbols.GROUP_SEP)) {
      return oldValue;
    }

    // NumberFormat.parse is not preventing decimal points on integers.
    if (newValue.text.contains(numberFormat.symbols.DECIMAL_SEP) &&
        numberFormat.maximumFractionDigits == 0) {
      return oldValue;
    }

    try {
      final parsed = numberFormat.parse(newValue.text);
      _logger.trace('parsed: ${newValue.text} -> $parsed');
      return newValue;
    } catch (_) {
      return oldValue;
    }
  }
}
