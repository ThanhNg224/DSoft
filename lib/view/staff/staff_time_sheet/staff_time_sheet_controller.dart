import 'package:intl/intl.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_time_sheet.dart';
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/model/response/model_time_sheet.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../bloc/staff_bloc.dart';
import '../staff_controller.dart';

class StaffTimeSheetController extends BaseController with Repository {
  StaffTimeSheetController(super.context);

  Widget errorWidget = const SizedBox();
  DateTime dateTimeValue = DateTime.now();
  final ServiceDateTimePicker dateTimePicker = ServiceDateTimePicker();
  final staffController = findController<StaffController>();
  List<TimeSheetCell> timeSheetCells = [];
  List<InfoStaff> staffList = [];
  List<staff.Data> listStaff = findController<StaffController>()
      .onTriggerEvent<StaffBloc>()
      .state.listStaff;
  late TimeSheetDataSource timeSheetDataSource;

  @override
  void onInitState() {
    final list = staffController.onTriggerEvent<StaffBloc>().state.listTimeSheet;
    final allStaff = listStaff;
    if (list.isEmpty) onGetListTimeSheet();
    staffList = allStaff.map((e) => InfoStaff(id: e.id, name: e.name)).toList();
    timeSheetCells = buildTimeSheetCells(list, staffList);
    timeSheetDataSource = TimeSheetDataSource(timeSheetCells, staffList);
    super.onInitState();
  }

  void onGetListTimeSheet({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final dateStart = "01/${dateTimeValue.formatDateTime(format: "MM/yyyy")}";
    final lastDay = DateUtils.getDaysInMonth(dateTimeValue.year, dateTimeValue.month);
    final dateEnd = "$lastDay/${dateTimeValue.formatDateTime(format: "MM/yyyy")}";
    final response = await listTimesheetAPI(ReqTimesheet(
        page: 1,
        type: "bonus",
        dateStart: dateStart,
        dateEnd: dateEnd,
    ));
    if (response is Success<ModelTimeSheet>) {
      if (response.value.code == Result.isOk) {
        final list = response.value.data ?? [];
        final allStaff = listStaff;

        staffList = allStaff.map((e) => InfoStaff(id: e.id, name: e.name)).toList();
        timeSheetCells = buildTimeSheetCells(list, staffList);
        onTriggerEvent<StaffBloc>().add(GetTimeSheetStaffEvent(list));
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được danh sách chấm công");
        setScreenState = screenStateError;
      }
    } else if (response is Failure<ModelTimeSheet>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  List<String> getDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    return List.generate(daysInMonth, (i) => DateFormat('dd/MM').format(firstDay.add(Duration(days: i))));
  }

  List<TimeSheetCell> buildTimeSheetCells(List<Data> timeSheetList, List<InfoStaff> staffList) {
    final allDates = getDaysInMonth(dateTimeValue);
    Map<String, Map<int, List<String>>> matrix = {};
    for (final date in allDates) {
      matrix[date] = {};
      for (var staff in staffList) {
        matrix[date]![staff.id ?? -1] = [];
      }
    }
    for (final entry in timeSheetList) {
      final checkInUnix = entry.checkIn;
      if (checkInUnix == null) continue;
      DateTime? parsedDate;
      try {
        parsedDate = DateTime.fromMillisecondsSinceEpoch(checkInUnix * 1000);
      } catch (_) {
        continue;
      }
      final formattedDay = DateFormat('dd/MM').format(parsedDate);
      final id = entry.idStaff ?? -1;
      if (matrix.containsKey(formattedDay)) {
        matrix[formattedDay]![id] = entry.shift ?? [];
      }
    }
    return matrix.entries
        .map((e) => TimeSheetCell(date: e.key, shiftsByStaff: e.value))
        .toList();
  }

  void onOpenSelectDateTime() async {
    final time = await dateTimePicker.open(context, initTime: dateTimeValue, type: TypeDateTime.monthYear);
    dateTimeValue = time;
    onGetListTimeSheet();
  }

  void onCheckTimesheet({InfoStaff? dataStaff, String? date, List<String>? dailySessions}) {
    final bloc = findController<StaffController>().onTriggerEvent<StaffBloc>();
    final state = findController<StaffController>().onTriggerEvent<StaffBloc>().state;
    if(dataStaff == null) {
      bloc.add(SetListDailySessionsStaffEvent([]));
      bloc.add(SetStaffTimeSheetStaffEvent(null));
    } else {
      bloc.add(SetListDailySessionsStaffEvent(dailySessions));
      bloc.add(SetStaffTimeSheetStaffEvent(staff.Data(
        id: dataStaff.id,
        name: dataStaff.name,
      )));
      final parts = (date ?? '').split('/');
      if (parts.length == 2) {
        final day = int.tryParse(parts[0]);
        final month = int.tryParse(parts[1]);
        final year = state.timekeepingDay.year;
        if (day != null && month != null) {
          final newDate = DateTime(year, month, day);
          bloc.add(SetTimekeepingDayStaffEvent(newDate));
        }
      }
    }
    popup(
      title: "Chấm công",
      content: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<StaffBloc, StaffState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetDropDow<staff.Data>(
                  topTitle: "Nhân viên",
                  title: "Chọn nhân viên",
                  validate: state.vaNameStaffTimeSheet,
                  content: listStaff.map((element) => WidgetDropSpan(value: element)).toList(),
                  getValue: (value) => value.name ?? "",
                  value: state.choseStaffTimeSheet,
                  onSelect: (value) => bloc.add(SetStaffTimeSheetStaffEvent(value)),
                ),
                const SizedBox(height: 8),
                WidgetCheckbox(
                  onChanged: (value) => _onChoseDaily(value!, state, "Sáng"),
                  value: state.listDailySessions.contains("Sáng"),
                  title: "Sáng",
                ),
                const SizedBox(height: 8),
                WidgetCheckbox(
                  onChanged: (value) => _onChoseDaily(value!, state, "Chiều"),
                  value: state.listDailySessions.contains("Chiều"),
                  title: "Chiều",
                ),
                const SizedBox(height: 8),
                WidgetCheckbox(
                  onChanged: (value) => _onChoseDaily(value!, state, "Tối"),
                  value: state.listDailySessions.contains("Tối"),
                  title: "Tối",
                ),
                const SizedBox(height: 8),
                Text("Tháng", style: TextStyles.def),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () => _choseTimekeepingDay(state),
                  child: SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: MyColor.borderInput)
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                          child: Text(state.timekeepingDay.formatDateTime(format: "dd/MM/yyyy"),
                              style: TextStyles.def)
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
      bottom: WidgetButton(
        title: "Chấm công",
        vertical: 8,
        onTap: () async {
          final state = findController<StaffController>().onTriggerEvent<StaffBloc>().state;
          final bloc = findController<StaffController>().onTriggerEvent<StaffBloc>();
          String vaName = state.choseStaffTimeSheet == null ? "Vui lòng chọn nhân viên" : "";
          bloc.add(SetVaNameStaffTimeSheetStaffEvent(vaName));
          if(state.listDailySessions.isEmpty) return warningSnackBar(message: "Vui lòng chọn thời gian");
          if(vaName.isNotEmpty) return;
          loadingFullScreen();
          final response = await checktimesheetAPI(
            date: state.timekeepingDay.formatDateTime(format: "dd/MM/yyyy"),
            idStaff: state.choseStaffTimeSheet?.id,
            shift: state.listDailySessions.join(', ')
          );
          hideLoading();
          if(response is Success<int>) {
            if(response.value == Result.isOk) {
              pop();
              onGetListTimeSheet(isLoad: false);
              successSnackBar(message: "Chấm công thành công cho nhân viên ${state.choseStaffTimeSheet?.name ?? ""}");
            } else {
              errorSnackBar(message: "Chấm công thất bại cho nhân viên ${state.choseStaffTimeSheet?.name ?? ""}");
            }
          }
          if(response is Failure<int>) {
            popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
          }
        },
      )
    );
  }

  void _choseTimekeepingDay(StaffState state) async {
    final time = await dateTimePicker.open(context, initTime: state.timekeepingDay, type: TypeDateTime.onlyDate);
    final bloc = findController<StaffController>().onTriggerEvent<StaffBloc>();
    bloc.add(SetTimekeepingDayStaffEvent(time));
  }

  void _onChoseDaily(bool value, StaffState state, String session) {
    final bloc = findController<StaffController>().onTriggerEvent<StaffBloc>();
    final updated = [...state.listDailySessions];
    if (value == true) {
      if (!updated.contains(session)) updated.add(session);
    } else {
      updated.remove(session);
    }
    bloc.add(SetListDailySessionsStaffEvent(updated));
  }

  void onChangeCell(DataGridCellTapDetails details) {
    final rowIndex = details.rowColumnIndex.rowIndex;
    final columnIndex = details.rowColumnIndex.columnIndex;
    if (rowIndex == 0 || columnIndex == 0) return;
    final cellData = timeSheetCells[rowIndex - 1];
    final date = cellData.date;
    final staff = staffList[columnIndex - 1];
    final staffId = staff.id ?? -1;
    final listDailySessions = cellData.shiftsByStaff[staffId] ?? [];
    onCheckTimesheet(dataStaff: staff, date: date, dailySessions: listDailySessions);
  }

}

class TimeSheetDataSource extends DataGridSource {
  final List<TimeSheetCell> data;
  final List<InfoStaff> staffList;

  TimeSheetDataSource(this.data, this.staffList) {
    _rows = data.map((entry) {
      List<DataGridCell> cells = [
        DataGridCell<String>(columnName: 'date', value: entry.date),
      ];
      for (var staff in staffList) {
        final shifts = entry.shiftsByStaff[staff.id] ?? [];
        cells.add(DataGridCell<String>(
          columnName: staff.id.toString(),
          value: shifts.join(', '),
        ));
      }
      return DataGridRow(cells: cells);
    }).toList();
  }

  late List<DataGridRow> _rows;

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        final isDateColumn = cell.columnName == 'date';
        final hasData = cell.value != null && cell.value.toString().trim().isNotEmpty;

        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
          color: !isDateColumn && hasData ? MyColor.green.o1 : null,
          child: Text(
            cell.value?.toString() ?? '',
            style: TextStyles.def,
            softWrap: true,
            maxLines: null,
          ),
        );
      }).toList(),
    );
  }
}

class TimeSheetCell {
  final String date;
  final Map<int, List<String>> shiftsByStaff;

  TimeSheetCell({required this.date, required this.shiftsByStaff});
}