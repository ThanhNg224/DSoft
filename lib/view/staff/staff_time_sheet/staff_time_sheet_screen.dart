import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/staff/bloc/staff_bloc.dart';
import 'package:spa_project/view/staff/staff_time_sheet/staff_time_sheet_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StaffTimeSheetScreen extends BaseView<StaffTimeSheetController> {
  const StaffTimeSheetScreen({super.key});

  @override
  StaffTimeSheetController createController(BuildContext context)
  => StaffTimeSheetController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      body: _body(),
    );
  }

  Widget _body() {
    if (controller.screenStateIsLoading) {
      return const Center(child: WidgetLoading());
    } else if (controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.errorWidget,
                Utilities.retryButton(() => controller.onGetListTimeSheet()),
              ],
            ),
          ),
        ),
      );
    } else {
      return BlocBuilder<StaffBloc, StaffState>(builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Tháng", style: TextStyles.def),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: controller.onOpenSelectDateTime,
                    child: SizedBox(
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: MyColor.borderInput)
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                            child: Text("Tháng ${controller.dateTimeValue.formatDateTime(format: "MM")}, "
                                "năm ${controller.dateTimeValue.formatDateTime(format: "yyyy")}",
                                style: TextStyles.def)
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SfDataGrid(
                source: TimeSheetDataSource(controller.timeSheetCells, controller.staffList),
                columnWidthMode: ColumnWidthMode.fill,
                frozenColumnsCount: 1,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                horizontalScrollPhysics: Utilities.defaultScroll,
                verticalScrollPhysics: Utilities.defaultScroll,
                onCellTap: controller.onChangeCell,
                columns: [
                  GridColumn(
                    columnName: 'date',
                    width: 80,
                    label: Center(
                      child: Text(
                        'Ngày',
                        style: TextStyles.def.size(12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ...controller.staffList.map((e) => GridColumn(
                    columnName: e.id.toString(),
                    width: 100,
                    label: Center(child: Text(e.name ?? '', style: TextStyles.def.size(12), textAlign: TextAlign.center)),
                  )),
                ],
              ),
            ),
          ],
        );
      });
    }
  }

}


