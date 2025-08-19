import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';

enum TypeDateTime { onlyDate, onlyTime, dateTime, monthYear, onlyDay }

class ServiceDateTimePicker {
  int _selectedDay = DateTime.now().day;
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;
  int _selectHour = DateTime.now().hour;
  int _selectMinute = DateTime.now().minute;
  final PageController _controller = PageController();
  String _btn = "Tiếp";
  int _countDay = 31;

  bool _isLeapYear(int year) => (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

  int _getDaysInMonth(int month, int year) {
    if (month == 2) return _isLeapYear(year) ? 29 : 28;
    return [4, 6, 9, 11].contains(month) ? 30 : 31;
  }

  void _next(BuildContext context) {
    if (_controller.page == 1) Navigator.pop(context);
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  Future<DateTime> open(BuildContext context, {TypeDateTime type = TypeDateTime.dateTime, DateTime? initTime}) {
    final completer = Completer<DateTime>();
    final initialDateTime = initTime ?? DateTime.now();

    _selectedDay = initialDateTime.day;
    _selectedMonth = initialDateTime.month;
    _selectedYear = initialDateTime.year;
    _selectHour = initialDateTime.hour;
    _selectMinute = initialDateTime.minute;
    _btn = "Tiếp";
    _countDay = _getDaysInMonth(_selectedMonth, _selectedYear);

    PopupOverlay.$PopupBottom(context, child: StatefulBuilder(
      builder: (context, state) {
        final views = <Widget>[];
        if (type == TypeDateTime.dateTime) {
          views.add(_dateView(state));
          views.add(_timeView(state));
        } else {
          final viewMap = {
            TypeDateTime.onlyDate: _dateView,
            TypeDateTime.onlyTime: _timeView,
            TypeDateTime.monthYear: _monthYearView,
            TypeDateTime.onlyDay: _onlyDayView,
          };
          views.add(viewMap[type]!(state));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(children: [
              Expanded(child: Text(_formattedDateTime(type), style: TextStyles.def)),
              TextButton(
                onPressed: () {
                  if (type == TypeDateTime.dateTime && _btn == "Tiếp") {
                    _next(context);
                    state(() => _btn = "Xong");
                  } else {
                    Navigator.of(context).pop();
                    completer.complete(_buildResult(type));
                  }
                },
                child: Text("   $_btn   ", style: TextStyles.def.bold.colors(MyColor.slateBlue)),
              ),
            ]),
            SizedBox(
              height: 250,
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: views,
              ),
            ),
          ],
        );
      },
    ));

    return completer.future;
  }

  DateTime _buildResult(TypeDateTime type) {
    final now = DateTime.now();
    final year = (type == TypeDateTime.onlyTime || type == TypeDateTime.onlyDay) ? now.year : _selectedYear;
    final month = (type == TypeDateTime.onlyTime || type == TypeDateTime.onlyDay) ? now.month : _selectedMonth;
    final day = _selectedDay;
    final hour = (type == TypeDateTime.onlyDate || type == TypeDateTime.monthYear || type == TypeDateTime.onlyDay) ? 0 : _selectHour;
    final minute = (type == TypeDateTime.onlyDate || type == TypeDateTime.monthYear || type == TypeDateTime.onlyDay) ? 0 : _selectMinute;
    return DateTime(year, month, day, hour, minute);
  }

  String _formattedDateTime(TypeDateTime type) {
    final d = _selectedDay.toString().padLeft(2, '0');
    final m = _selectedMonth.toString().padLeft(2, '0');
    final y = _selectedYear.toString();
    final h = _selectHour.toString().padLeft(2, '0');
    final min = _selectMinute.toString().padLeft(2, '0');
    switch (type) {
      case TypeDateTime.onlyDay:
        return "Ngày $d";
      case TypeDateTime.onlyDate:
        return "$d/$m/$y";
      case TypeDateTime.onlyTime:
        return "$h:$min";
      case TypeDateTime.monthYear:
        return "Tháng $m/$y";
      case TypeDateTime.dateTime:
      return "$d/$m/$y - $h:$min";
    }
  }

  Widget _dateView(void Function(void Function()) state) {
    return Row(children: [
      Expanded(
        child: CupertinoPicker(
          itemExtent: 40,
          scrollController: FixedExtentScrollController(initialItem: _selectedDay - 1),
          onSelectedItemChanged: (index) => state(() => _selectedDay = index + 1),
          children: List.generate(_countDay, (i) => Center(child: Text("${i + 1}", style: const TextStyle(fontSize: 20)))),
        ),
      ),
      Expanded(
        child: CupertinoPicker(
          itemExtent: 40,
          scrollController: FixedExtentScrollController(initialItem: _selectedMonth - 1),
          onSelectedItemChanged: (index) {
            state(() {
              _selectedMonth = index + 1;
              _countDay = _getDaysInMonth(_selectedMonth, _selectedYear);
              if (_selectedDay > _countDay) _selectedDay = _countDay;
            });
          },
          children: List.generate(12, (i) => Center(child: Text("Tháng ${i + 1}", style: const TextStyle(fontSize: 20)))),
        ),
      ),
      Expanded(
        child: CupertinoPicker(
          itemExtent: 40,
          scrollController: FixedExtentScrollController(initialItem: _selectedYear - 2000),
          onSelectedItemChanged: (index) {
            state(() {
              _selectedYear = 2000 + index;
              _countDay = _getDaysInMonth(_selectedMonth, _selectedYear);
              if (_selectedDay > _countDay) _selectedDay = _countDay;
            });
          },
          children: List.generate(101, (i) => Center(child: Text("${2000 + i}", style: const TextStyle(fontSize: 20)))),
        ),
      ),
    ]);
  }

  Widget _timeView(void Function(void Function()) state) {
    return Column(
      children: [
        const Row(children: [
          Expanded(child: Text("Giờ", textAlign: TextAlign.center)),
          Expanded(child: Text("Phút", textAlign: TextAlign.center)),
        ]),
        Expanded(
          child: Row(children: [
            Expanded(
              child: CupertinoPicker(
                itemExtent: 40,
                scrollController: FixedExtentScrollController(initialItem: _selectHour),
                onSelectedItemChanged: (index) => state(() => _selectHour = index),
                children: List.generate(24, (i) => Center(child: Text(i.toString().padLeft(2, '0'), style: const TextStyle(fontSize: 20)))),
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 40,
                scrollController: FixedExtentScrollController(initialItem: _selectMinute),
                onSelectedItemChanged: (index) => state(() => _selectMinute = index),
                children: List.generate(60, (i) => Center(child: Text(i.toString().padLeft(2, '0'), style: const TextStyle(fontSize: 20)))),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _monthYearView(void Function(void Function()) state) {
    return Row(children: [
      Expanded(
        child: CupertinoPicker(
          itemExtent: 40,
          scrollController: FixedExtentScrollController(initialItem: _selectedMonth - 1),
          onSelectedItemChanged: (index) => state(() => _selectedMonth = index + 1),
          children: List.generate(12, (i) => Center(child: Text("Tháng ${i + 1}", style: const TextStyle(fontSize: 20)))),
        ),
      ),
      Expanded(
        child: CupertinoPicker(
          itemExtent: 40,
          scrollController: FixedExtentScrollController(initialItem: _selectedYear - 2000),
          onSelectedItemChanged: (index) => state(() => _selectedYear = 2000 + index),
          children: List.generate(101, (i) => Center(child: Text("${2000 + i}", style: const TextStyle(fontSize: 20)))),
        ),
      ),
    ]);
  }

  Widget _onlyDayView(void Function(void Function()) state) {
    final count = _getDaysInMonth(_selectedMonth, _selectedYear);

    return Center(
      child: CupertinoPicker(
        itemExtent: 40,
        scrollController: FixedExtentScrollController(initialItem: _selectedDay - 1),
        onSelectedItemChanged: (index) {
          state(() => _selectedDay = index + 1);
        },
        children: List.generate(count, (i) {
          return Center(
            child: Text("Ngày ${i + 1}", style: const TextStyle(fontSize: 20)),
          );
        }),
      ),
    );
  }

}