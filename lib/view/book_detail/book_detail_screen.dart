import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_book_calendar.dart';
import 'package:spa_project/view/book_detail/book_detail_controller.dart';
import 'package:spa_project/view/book_detail/book_detail_cubit.dart';

class BookDetailScreen extends BaseView<BookDetailController> {
  static const String router = "/BookDetailScreen";
  const BookDetailScreen({super.key});

  @override
  BookDetailController createController(BuildContext context)
  => BookDetailController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<BookDetailCubit, Data>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MyColor.softWhite,
          appBar: WidgetAppBar(
            title: "Thông tin lịch hẹn",
            actionIcon: state.status == StatusBook.pending
                ? const Icon(Icons.edit, color: MyColor.darkNavy) : null,
            actionActive: controller.toEditBook,
          ),
          body: _body(state),
          bottomNavigationBar: state.status == StatusBook.pending ? SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Row(children: [
                Expanded(child: WidgetButton(
                  title: "Check in",
                  vertical: 0,
                  onTap: controller.onCheckIn,
                )),
                const SizedBox(width: 10),
                Expanded(child: WidgetButton(
                  title: "Xóa lịch",
                  vertical: 0,
                  borderColor: MyColor.red,
                  color: MyColor.nowhere,
                  styleTitle: TextStyles.def.colors(MyColor.red).size(15).bold,
                  onTap: ()=> controller.onDeleteBook(),
                )),
              ]),
            ),
          ) : const SizedBox(),
        );
      }
    );
  }

  Widget _body(Data state) {
    if(controller.screenStateIsLoading) {
      return WidgetListView(children: const [
        SizedBox(height: 20),
        WidgetShimmer(radius: 20, width: double.infinity, height: 200),
        SizedBox(height: 20),
        WidgetShimmer(radius: 20, width: double.infinity, height: 200),
      ]);
    } else if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.errorWidget,
              const SizedBox(height: 10),
              Utilities.retryButton(()=> GetDetailBook().perform()),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      return WidgetListView(
        children: [
          Text("Khách hàng", style: TextStyles.def.bold.size(16)),
          const SizedBox(height: 10),
          WidgetBoxColor(
              closed: ClosedEnd.start,
              closedBot: ClosedEnd.end,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.name ?? "Đang cập nhật", style: TextStyles.def.bold.size(25)),
                    const SizedBox(height: 10),
                    _itemDetailCalendarSelect(
                        icon: Icons.phone,
                        title: "Số điện thoại: ",
                        value: state.phone
                    ),
                    const SizedBox(height: 8),
                    _itemDetailCalendarSelect(
                        icon: Icons.mail,
                        title: "Email: ",
                        value: (state.email != null && state.email != "")
                            ? state.email
                            : "Đang cập nhật"
                    ),
                    const SizedBox(height: 8),
                    _itemDetailCalendarSelect(
                        icon: Icons.access_time_filled_sharp,
                        title: "Thời gia đặt: ",
                        value: (state.timeBook)?.formatUnixToHHMMYYHHMM() ?? "Đang cập nhật"
                    ),
                    const SizedBox(height: 8),
                    Text("Ghi chú", style: TextStyles.def.bold),
                    SizedBox(
                      width: double.infinity,
                      child: Text(state.note ?? "Không có ghi chú nào", style: TextStyles.def.colors(
                          state.note?.trim() == null ? MyColor.hideText : MyColor.darkNavy
                      ), textAlign: state.note == null ? TextAlign.center : TextAlign.start),
                    )
                  ],
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              Text("Dịch vụ", style: TextStyles.def.bold.size(16)),
              const Expanded(child: Divider(indent: 20, color: MyColor.sliver))
            ]),
          ),
          WidgetBoxColor(
              closed: ClosedEnd.start,
              closedBot: ClosedEnd.end,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _itemDetailCalendarSelect(
                        title: "Dịch vụ: ",
                        value: state.services?.name
                    ),
                    const SizedBox(height: 8),
                    _itemDetailCalendarSelect(
                        title: "Nhân viên phụ trách: ",
                        value: state.members?.name
                    ),
                    const SizedBox(height: 8),
                    _itemDetailCalendarSelect(
                        title: "Trạng thái: ",
                        value: Utilities.statusCodeSpaToMes(state.status)
                    ),
                    const SizedBox(height: 8),
                    if(Utilities.getSelectedTypes(state)!.isNotEmpty) _itemDetailCalendarSelect(
                        title: "Kiểu đặt: ",
                        value: Utilities.getSelectedTypes(state)
                    ),
                    const SizedBox(height: 8),
                    _itemDetailCalendarSelect(
                        title: "Phòng: ",
                        value: state.beds?.name
                    ),
                  ],
                ),
              )
          )
        ]
      );
    }
  }

  Widget _itemDetailCalendarSelect({IconData? icon, String? title, String? value}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(icon != null) Icon(icon, color: MyColor.hideText, size: 18),
      if(icon != null) const SizedBox(width: 10),
      Expanded(child: Text(title ?? "", style: TextStyles.def.bold)),
      Expanded(child: Align(
        alignment: Alignment.centerRight,
        child: Text(value ?? "",
          style: TextStyles.def.colors(MyColor.slateGray),
        ),
      )),
    ]);
  }

}