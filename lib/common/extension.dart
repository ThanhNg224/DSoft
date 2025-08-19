import 'package:intl/intl.dart';

extension StringExtensions on String {
  String removeString(String pattern) {
    return replaceAll(pattern, "").trim();
  }

  int get removeCommaMoney {
    final cleaned = replaceAll(".", "").trim();
    return int.tryParse(cleaned) ?? 0;
  }

}

extension NumberFormatter on num {
  String formatNumberShort() {
    if (this >= 1000000) {
      return "${(this / 1000000).toStringAsFixed((this % 1000000 == 0) ? 0 : 1)}M";
    } else if (this >= 1000) {
      return "${(this / 1000).toStringAsFixed((this % 1000 == 0) ? 0 : 1)}k";
    } else {
      return toStringAsFixed((this % 1 == 0) ? 0 : 1);
    }
  }

  String toCurrency({String suffix = ""}) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return suffix.isEmpty ? formatter.format(this) : "${formatter.format(this)}$suffix";
  }

  String formatUnixTimeToMonthYear() {
    final date = DateTime.fromMillisecondsSinceEpoch(toInt() * 1000);
    return "tháng ${date.month}, năm ${date.year}";
  }

  String formatUnixTimeToDateDDMMYYYY({String? format}) {
    final date = DateTime.fromMillisecondsSinceEpoch(toInt() * 1000);
    return DateFormat(format ?? 'dd/MM/yyyy').format(date);
  }

  String formatUnixTimeToWeekday() {
    final date = DateTime.fromMillisecondsSinceEpoch(toInt() * 1000);
    const weekdays = [
      'Chủ nhật',
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
    ];

    String weekdayStr = weekdays[date.weekday % 7];

    return weekdayStr;
  }

  String formatUnixTimeToHHMM() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch((this as int) * 1000);
    String hours = dateTime.hour.toString().padLeft(2, '0');
    String minutes = dateTime.minute.toString().padLeft(2, '0');
    return "$hours:$minutes";
  }

  String formatUnixToHHMMYYHHMM() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch((this as int) * 1000);
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  DateTime get toDateTime => DateTime.fromMillisecondsSinceEpoch((this as int) * 1000);
}

extension DateTimeFormatter on DateTime {

  static const List<String> _days = [
    'Chủ nhật', 'Thứ hai', 'Thứ ba', 'Thứ tư',
    'Thứ năm', 'Thứ sáu', 'Thứ bảy'
  ];

  static const List<String> _months = [
    'tháng 1', 'tháng 2', 'tháng 3', 'tháng 4',
    'tháng 5', 'tháng 6', 'tháng 7', 'tháng 8',
    'tháng 9', 'tháng 10', 'tháng 11', 'tháng 12'
  ];

  String get formatDateTimeToEEddMM {
    String dayOfWeek = _days[weekday % 7];
    String day = this.day.toString().padLeft(2, '0');
    String month = _months[this.month - 1];
    return "$dayOfWeek, $day $month";
  }

  String get formatDateTimeToMothYear {
    return 'Tháng $month, $year';
  }

  String formatDateTime({String format = "dd/MM/yyyy HH:mm"}) {
    return DateFormat(format).format(this);
  }

  int get formatDateTimeToUnix => millisecondsSinceEpoch ~/ 1000;
}
