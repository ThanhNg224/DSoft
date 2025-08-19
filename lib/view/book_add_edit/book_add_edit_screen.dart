import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_drop_dow_bed.dart';
import 'package:spa_project/model/common/model_drop_dow_service.dart';
import 'package:spa_project/model/common/model_drop_dow_staff.dart';
import 'package:spa_project/model/common/model_drop_dow_status.dart';
import 'package:spa_project/view/book_add_edit/bloc/book_add_edit_bloc.dart';
import 'package:spa_project/view/book_add_edit/book_add_edit_controller.dart';

class BookAddEditScreen extends BaseView<BookAddEditController> {
  static const String router = "/BookAddEditScreen";
  const BookAddEditScreen({super.key});

  @override
  BookAddEditController createController(BuildContext context)
  => BookAddEditController(context);

  @override
  Widget zBuild() {
    return GestureDetector(
      onTap: Utilities.dismissKeyboard,
      child: BlocBuilder<BookAddEditBloc, BookAddEditState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: WidgetAppBar(title: state.titleAppbar),
            body: BlocBuilder<BookAddEditBloc, BookAddEditState>(
              builder: (context, state) {
                return WidgetListView(
                  children: [
                    _boxNameCustomer(state),
                    WidgetBoxColor(
                      child: WidgetInput(
                        title: "Số điện thoại",
                        tick: true,
                        hintText: "Nhập số điện thoại",
                        controller: controller.cPhone,
                        keyboardType: TextInputType.number,
                        validateValue: state.vaPhone,
                      ),
                    ),
                    _boxBookTime(state),
                    WidgetBoxColor(
                      child: WidgetDropDow<ModelDropDowService>(
                          title: "Chọn dịch vụ",
                          topTitle: "Dịch vụ",
                          tick: true,
                          content: List.generate(controller.serviceDrop().length, (index) {
                            return WidgetDropSpan(
                                value: controller.serviceDrop()[index],
                                isCategory: controller.serviceDrop()[index].isCategory
                            );
                          }),
                          validate: state.vaService,
                          value: state.serviceValue,
                          getValue: (item) => item.name ?? "Đang cập nhật",
                          onSelect: (item) => context.read<BookAddEditBloc>().add(
                              ChoseDropDowBookAddEditEvent(serviceValue: item)
                          )
                      ),
                    ),
                    WidgetBoxColor(
                      child: WidgetDropDow<ModelDropDowStaff>(
                          title: "Chọn nhân viên",
                          topTitle: "Nhân viên phụ trách",
                          tick: true,
                          content: List.generate(controller.listStaffDrop.length, (index) {
                            return WidgetDropSpan(value: controller.listStaffDrop[index]);
                          }),
                          validate: state.vaStaff,
                          value: state.staffValue,
                          getValue: (item) => item.name ?? "",
                          onSelect: (item) => context.read<BookAddEditBloc>().add(
                              ChoseDropDowBookAddEditEvent(staffValue: item)
                          )
                      ),
                    ),
                    WidgetBoxColor(
                      child: WidgetDropDow<ModelDropDowBed>(
                          title: "Chọn giường",
                          tick: true,
                          topTitle: "Giường & phòng",
                          content: List.generate(controller.bedDrop().length, (index) {
                            return WidgetDropSpan(value: controller.bedDrop()[index], isCategory: controller.bedDrop()[index].isCategory);
                          }),
                          validate: state.vaBed,
                          value: state.bedValue,
                          getValue: (item) => item.name ?? "Đang cập nhật",
                          onSelect: (item) => context.read<BookAddEditBloc>().add(
                              ChoseDropDowBookAddEditEvent(bedValue: item)
                          )
                      ),
                    ),
                    WidgetBoxColor(
                      child: WidgetInput(
                        title: "Email",
                        hintText: "Nhập email",
                        controller: controller.cEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    WidgetBoxColor(
                      child: WidgetDropDow<ModelDropDowStatus>(
                        title: "Chọn trạng thái",
                        topTitle: "Trạng thái",
                        content: List.generate(controller.statusDrop.length, (index) {
                          return WidgetDropSpan(value: controller.statusDrop[index]);
                        }),
                        value: state.statusValue,
                        getValue: (item) => item.name ?? "",
                        onSelect: (item) => context.read<BookAddEditBloc>().add(
                          ChoseDropDowBookAddEditEvent(statusValue: item)
                        ),
                      ),
                    ),
                    WidgetBoxColor(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text("Kiểu đặt", style: TextStyles.def.bold),
                        const SizedBox(height: 8),
                        WidgetCheckbox(
                          title: "Lịch tư vấn",
                          onChanged: (_) => context.read<BookAddEditBloc>().add(
                            SetBookingTypeBookAddEditEvent(isConsultation: !state.isConsultation)
                          ),
                          value: state.isConsultation,
                        ),
                        const SizedBox(height: 8),
                        WidgetCheckbox(
                          title: "Lịch chăm sóc",
                          value: state.isCare,
                          onChanged: (_) => context.read<BookAddEditBloc>().add(
                            SetBookingTypeBookAddEditEvent(isCare: !state.isCare)
                          )
                        ),
                        const SizedBox(height: 8),
                        WidgetCheckbox(
                          title: "Lịch liệu trình",
                          value: state.isTreatmentPlan,
                          onChanged: (_) => context.read<BookAddEditBloc>().add(
                            SetBookingTypeBookAddEditEvent(isTreatmentPlan: !state.isTreatmentPlan)
                          )
                        ),
                        const SizedBox(height: 8),
                        WidgetCheckbox(
                          title: "Lịch điều trị",
                          value: state.isTherapy,
                          onChanged: (_) => context.read<BookAddEditBloc>().add(
                            SetBookingTypeBookAddEditEvent(isTherapy: !state.isTherapy)
                          )
                        ),
                      ],
                    )),
                    WidgetBoxColor(
                      closedBot: ClosedEnd.end,
                      child: WidgetInput(
                        title: "Thông tin thêm",
                        hintText: "Nhập nội dung",
                        maxLines: 3,
                        controller: controller.cNote,
                      )
                    )
                  ]
                );
              }
            ),
            bottomNavigationBar: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: WidgetButton(
                  title: state.titleButton,
                  vertical: 0,
                  onTap: controller.onCreateEdit,
                ),
              ),
            ),
          );
        }
      ),
    );
  }
  
  Widget _boxNameCustomer(BookAddEditState state) {
    return WidgetBoxColor(
      closed: ClosedEnd.start,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            Text("Tên khách hàng", style: TextStyles.def),
            const SizedBox(width: 5),
            Text("*", style: TextStyles.def.size(18).colors(MyColor.red))
          ]),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: controller.onOpenViewSearch,
            child: SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: state.vaName.isEmpty ? MyColor.borderInput : MyColor.red)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                  child: state.vaName.isEmpty ? Text(controller.nameCustomer.name ?? "Nhập tên khách hàng",
                      style: TextStyles.def.colors(controller.nameCustomer.name == null
                          ? MyColor.hideText
                          : MyColor.darkNavy
                      )
                  ) : Text(state.vaName, style: TextStyles.def.colors(MyColor.red)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _boxBookTime(BookAddEditState state) {
    return WidgetBoxColor(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            Text("Thời gian", style: TextStyles.def),
            const SizedBox(width: 5),
            Text("*", style: TextStyles.def.size(18).colors(MyColor.red))
          ]),
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
                  child: Text(controller.dateTimeValue.formatDateTime(), style: TextStyles.def)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}