import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum TypeFormatInput {
  money,
  notCharacters,
  number
}

class AutoFormatInput extends TextInputFormatter {
  final TypeFormatInput type;
  final NumberFormat _moneyFormatter = NumberFormat("#,###", "en_US");

  AutoFormatInput({this.type = TypeFormatInput.money});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: '0',
        selection: TextSelection.collapsed(offset: 1),
      );
    }

    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isNotEmpty) {
      digitsOnly = digitsOnly.replaceFirst(RegExp(r'^0+(?=.)'), '');
      if (digitsOnly.isEmpty) digitsOnly = '0';
    }

    switch (type) {
      case TypeFormatInput.money:
        if (digitsOnly.isEmpty) {
          return const TextEditingValue(
            text: '0',
            selection: TextSelection.collapsed(offset: 1),
          );
        }
        final number = int.parse(digitsOnly);
        final formatted = _moneyFormatter.format(number).replaceAll(',', '.');
        return TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );

      case TypeFormatInput.notCharacters:
        return TextEditingValue(
          text: digitsOnly.isEmpty ? '0' : digitsOnly,
          selection: TextSelection.collapsed(offset: digitsOnly.isEmpty ? 1 : digitsOnly.length),
        );

      case TypeFormatInput.number:
        return TextEditingValue(
          text: digitsOnly.isEmpty ? '0' : digitsOnly,
          selection: TextSelection.collapsed(
            offset: digitsOnly.isEmpty ? 1 : digitsOnly.length,
          ),
        );
    }
  }
}