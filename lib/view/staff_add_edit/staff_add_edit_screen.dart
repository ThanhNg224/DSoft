import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/common/format_input/auto_money_input.dart';
import 'package:spa_project/model/response/model_group_staff.dart' as group;
import 'package:spa_project/model/response/model_list_banking.dart';
import 'package:spa_project/model/response/model_list_permission.dart' as permission;
import 'package:spa_project/view/staff_add_edit/bloc/staff_add_edit_bloc.dart';
import 'package:spa_project/view/staff_add_edit/staff_add_edit_controller.dart';

class StaffAddEditScreen extends BaseView<StaffAddEditController> {
  static const String router = "/StaffAddEditScreen";
  const StaffAddEditScreen({super.key});

  @override
  StaffAddEditController createController(BuildContext context)
  => StaffAddEditController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<StaffAddEditBloc, StaffAddEditState>(
      builder: (context, state) {
        if(controller.screenStateIsError) {
          return SizedBox(
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    controller.errorWidget,
                    const SizedBox(height: 10),
                    Utilities.retryButton(() => controller.onGetMulti()),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        }
        return GestureDetector(
          onTap: Utilities.dismissKeyboard,
          child: Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: WidgetAppBar(title: state.titleAppbar),
            bottomNavigationBar: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: WidgetButton(
                  title: state.titleButton,
                  vertical: 0,
                  onTap: controller.onAddEditStaff,
                ),
              ),
            ),
            body: WidgetListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              children: [
                WidgetBoxColor(
                  closed: ClosedEnd.start,
                  child: Center(
                    child: GestureDetector(
                      onTap: controller.onAvatarPicker,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          WidgetAvatar(size: 180, url: state.imageFile),
                          Transform.translate(
                            offset: const Offset(0, -10),
                            child: Utilities.iconCamera(size: 30)
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                WidgetBoxColor(
                  child: WidgetInput(
                    title: "Tên nhân viên",
                    tick: true,
                    hintText: "Nhập tên nhân viên",
                    controller: controller.cName,
                    validateValue: state.vaName,
                  )
                ),
                WidgetBoxColor(
                  child: WidgetInput(
                    title: "Địa chỉ",
                    hintText: "Nhập địa chỉ",
                    controller: controller.cAddress,
                  )
                ),
                WidgetBoxColor(
                  child: WidgetInput(
                    title: "Số điện thoại",
                    hintText: "Nhập số điện thoại",
                    keyboardType: TextInputType.number,
                    tick: true,
                    controller: controller.cPhone,
                    validateValue: state.vaPhone,
                  )
                ),
                WidgetBoxColor(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sinh nhật", style: TextStyles.def),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: ()=> controller.onChoseDate(),
                        child: SizedBox(
                          width: double.infinity,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: MyColor.borderInput),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                              child: Text(state.valueBirthday.isNotEmpty ? state.valueBirthday : "Nhập ngày sinh nhật", style: TextStyles.def),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                WidgetBoxColor(
                  child: Row(children: [
                    Text("Trạng thái: ", style: TextStyles.def.size(18).bold),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 1000),
                        transitionBuilder: (child, animation) {
                          final curved = CurvedAnimation(
                            parent: animation,
                            curve: Curves.elasticInOut,
                          );
                          return ScaleTransition(
                            scale: curved,
                            alignment: Alignment.centerLeft,
                            child: child
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          key: ValueKey(state.statusAccount),
                          child: Text(
                            state.statusAccount == StatusAccountStaff.isLock ? "Khóa" : "Kích hoạt",
                            textAlign: TextAlign.left,
                            style: TextStyles.def.size(18).bold.colors(StatusAccountStaff.color(state.statusAccount)),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.change_circle_sharp),
                      onPressed: ()=> context.read<StaffAddEditBloc>().add(ChangeStatusAccountStaffAddEditEvent()),
                    )
                  ])
                ),
                WidgetBoxColor(
                  child: WidgetDropDow<group.Data>(
                    title: "Chọn nhóm nhân viên",
                    topTitle: "Nhóm nhân viên",
                    content: List.generate(state.listGroup.length, (index) {
                      return WidgetDropSpan(value: state.listGroup[index]);
                    }),
                    value: state.itemChoseGroup,
                    getValue: (item) => item.name ?? "",
                    onSelect: (item) => context.read<StaffAddEditBloc>().add(ChoseGroupStaffAddEditEvent(item)),
                  )
                ),
                WidgetBoxColor(
                  child: WidgetInput(
                    title: "Mật khẩu",
                    tick: true,
                    hintText: "Nhập mật khẩu",
                    controller: controller.cPass,
                    validateValue: state.vaPass,
                    obscureText: true,
                  )
                ),
                WidgetBoxColor(child: WidgetInput(
                  title: "Lương cứng",
                  hintText: "Lương cứng",
                  tick: true,
                  controller: controller.cFixedSalary,
                  validateValue: state.vaFixedSalary,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
                  ),
                  inputFormatters: [AutoFormatInput()],
                  keyboardType: TextInputType.number,
                )),
                WidgetBoxColor(child: WidgetInput(
                  title: "Tiền đóng bảo hiểm",
                  hintText: "Tiền đóng bảo hiểm",
                  controller: controller.cInsurance,
                  tick: true,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
                  ),
                  inputFormatters: [AutoFormatInput()],
                  validateValue: state.vaInsurance,
                  keyboardType: TextInputType.number,
                )),
                WidgetBoxColor(child: WidgetInput(
                  title: "Tiền phụp cấp",
                  tick: true,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
                  ),
                  inputFormatters: [AutoFormatInput()],
                  hintText: "Tiền phụp cấp",
                  controller: controller.cAllowance,
                  validateValue: state.vaAllowance,
                  keyboardType: TextInputType.number,
                )),
                WidgetBoxColor(child: WidgetInput(
                  title: "Số tài khoản ngân hàng",
                  hintText: "Số tài khoản",
                  validateValue: state.vaAccountBank,
                  inputFormatters: [AutoFormatInput(type: TypeFormatInput.notCharacters)],
                  controller: controller.cAccountBank,
                  tick: true,
                  keyboardType: TextInputType.number,
                )),
                WidgetBoxColor(
                  child: WidgetDropDow<ModelListBanking>(
                    title: "Ngân hàng",
                    topTitle: "Ngân hàng",
                    validate: state.vaCodeBank,
                    tick: true,
                    value: state.valueBankChose,
                    content: List.generate(state.listBank.length, (index) {
                      return WidgetDropSpan(value: state.listBank[index]);
                    }),
                    enableSearch: true,
                    getValue: (item) => "${item.name} (${item.code})",
                    onSelect: (item) => context.read<StaffAddEditBloc>().add(ChoseBankStaffAddEditEvent(item)),
                  )
                ),
                WidgetBoxColor(child: WidgetInput(
                  title: "Số căn cước công dân",
                  hintText: "Căn cước công dân",
                  validateValue: state.vaIdCard,
                  tick: true,
                  keyboardType: TextInputType.number,
                  controller: controller.cidCard,
                )),
                WidgetBoxColor(
                  closedBot: ClosedEnd.end,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("quyền hạnh", style: TextStyles.def),
                      const SizedBox(height: 10),
                      ...List.generate(state.listPermission.length, (perIndex) {
                        final permissionGroup = state.listPermission[perIndex];
                        return GestureDetector(
                          onTap: () => context.read<StaffAddEditBloc>().add(ChangeTabPermissionStaffAddEditEvent(perIndex)),
                          child: WidgetDropCheckBox<permission.Sub>(
                              isExpanded: perIndex == state.indexPermissionTab,
                              onChanged: (selectedItems) {
                                final newSelectedPermissions = List<permission.Sub>.from(state.selectedPermissionsByGroup);
                                final currentGroupSubs = state.listPermission[perIndex].sub ?? [];
                                newSelectedPermissions.removeWhere((item) =>
                                    currentGroupSubs.any((sub) => sub.permission == item.permission));
                                newSelectedPermissions.addAll(selectedItems);
                                context.read<StaffAddEditBloc>().add(
                                    ChosePermissionStaffAddEditEvent(newSelectedPermissions)
                                );
                              },
                              title: permissionGroup.name,
                              getLabel: (item) => item.name ?? "",
                              children: List.generate(state.listPermission[perIndex].sub?.length ?? 0, (subIndex) {
                                final sub = state.listPermission[perIndex].sub?[subIndex];
                                final isChecked = state.selectedPermissionsByGroup
                                    .any((selected) => selected.permission == sub?.permission);
                                return WidgetDropItem<permission.Sub>(
                                  value: sub!,
                                  isCheck: isChecked,
                                );
                              })
                          ),
                        );
                      })
                    ]
                  )
                ),
              ]
            ),
          ),
        );
      }
    );
  }
}