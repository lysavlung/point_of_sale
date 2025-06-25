/// Utility for accounting-style currency formatting
String formatAccounting(double value, {String currency = '\$'}) {
  if (value < 0) {
    return '(${currency}${value.abs().toStringAsFixed(2)})';
  } else {
    return '$currency${value.toStringAsFixed(2)}';
  }
}
