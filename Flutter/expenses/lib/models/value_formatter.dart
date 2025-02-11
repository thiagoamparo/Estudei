import 'dart:math';

class ValueFormatter {
  static const String _cipher = '\$';
  static const String _emptySuffix = '';
  static const String _unlimitedNotation = '+';
  static const String _restrictedNotation = '-';
  static const String _scientificNotation = 'e+';
  static const int _baseExponent = 3;
  static const int _fractionDigits = 2;
  static const int _roundDigits = 0;
  static const Map<int, String> _suffixes = {
    3: 'K',
    6: 'M',
    9: 'B',
    12: 'T',
    15: 'Q',
    18: 'Qi',
    21: 'S',
    24: 'Se',
    27: 'O',
    30: 'N',
    33: 'D',
  };

  double value;
  String cipher;
  String emptySuffix;
  String unlimitedNotation;
  String restrictedNotation;
  String scientificNotation;
  int baseExponent;
  int fractionDigits;
  int roundDigits;
  Map<int, String> suffixes;

  int exponent = 0;
  double trimValue = 0.0;
  String stringValue = '';
  String suffix = '';
  String valueFormatter = '';

  ValueFormatter(
    this.value, {
    this.cipher = _cipher,
    this.emptySuffix = _emptySuffix,
    this.unlimitedNotation = _unlimitedNotation,
    this.restrictedNotation = _restrictedNotation,
    this.scientificNotation = _scientificNotation,
    this.baseExponent = _baseExponent,
    this.fractionDigits = _fractionDigits,
    this.roundDigits = _roundDigits,
    this.suffixes = _suffixes,
  }) {
    stringValue = _stringValue;
    trimValue = _trimValue;
    exponent = _exponent;
    suffix = _suffix;

    valueFormatter = _format();
  }

  @override
  String toString() => valueFormatter;

  double toDouble() => value;

  String get _stringValue => value.toStringAsExponential(fractionDigits);

  double get _trimValue {
    return double.tryParse(stringValue.split(scientificNotation).first) ??
        value;
  }

  int get _exponent {
    return int.tryParse(stringValue.split(scientificNotation).last) ??
        (log(value) / log(10)).ceil();
  }

  String get _suffix {
    return (exponent < suffixes.keys.first)
        ? emptySuffix
        : (exponent < suffixes.keys.last && !suffixes.keys.contains(exponent))
            ? '${suffixes[_normalizedExponent]}$restrictedNotation'
            : suffixes[exponent] ?? suffixes.values.last + _unlimitedNotation;
  }

  int get _normalizedExponent => (exponent ~/ baseExponent) * baseExponent;

  String _format() {
    if (exponent < suffixes.keys.first) {
      return cipher + value.toStringAsFixed(fractionDigits);
    } else if (trimValue % 1 == 0) {
      return cipher + trimValue.toStringAsFixed(roundDigits) + suffix;
    } else {
      return cipher + trimValue.toStringAsFixed(fractionDigits) + suffix;
    }
  }

  String get valueWithoutCipher => valueFormatter.replaceFirst(_cipher, '');

  static String formatter(
    double value, {
    String cipher = _cipher,
    String emptySuffix = _emptySuffix,
    String unlimitedNotation = _unlimitedNotation,
    String restrictedNotation = _restrictedNotation,
    String scientificNotation = _scientificNotation,
    int baseExponent = _baseExponent,
    int fractionDigits = _fractionDigits,
    Map<int, String> suffixes = _suffixes,
  }) {
    return ValueFormatter(value,
            cipher: cipher,
            emptySuffix: emptySuffix,
            unlimitedNotation: unlimitedNotation,
            restrictedNotation: restrictedNotation,
            scientificNotation: scientificNotation,
            baseExponent: baseExponent,
            fractionDigits: fractionDigits,
            suffixes: suffixes)
        ._format();
  }
}
