import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_book_calendar.dart';
import 'package:spa_project/view/book/bloc/book_bloc.dart';
import 'package:spa_project/view/book/book_controller.dart';

class BookScreen extends BaseView<BookController> {
  static const String router = "/BookScreen";
  const BookScreen({super.key});

  @override
  BookController createController(context) => BookController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: WidgetAppBar(
        title: "Đặt lịch",
        actionIcon: WidgetButton(
          iconLeading: Icons.add,
          horizontal: 10,
          vertical: 0,
          onTap: ()=> controller.toAddEditBook(),
        ),
      ),
      body: _body()
    );
  }

  Widget _body() {
    if(controller.screenStateIsLoading) {
      return _loading();
    } else if(controller.screenStateIsError) {
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
                SizedBox(
                  width: 120,
                  child: WidgetButton(
                    vertical: 7,
                    title: "Thử lại",
                    onTap: ()=> controller.onGetMulti(true),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      return BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          return WidgetListView(
            onRefresh: () async => controller.onGetMulti(false),
            children: [
              _itemHeader(),
              const SizedBox(height: 16),
              if(state.isShowViewTypeList && state.listBook.isNotEmpty) WidgetBoxColor(
                closed: ClosedEnd.start,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColor.borderInput
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Row(children: [
                      Expanded(
                        flex: 2,
                        child: Text("Tên khách hàng", style: TextStyles.def
                            .size(13).colors(MyColor.slateGray).bold),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text("Dịch vụ", style: TextStyles.def
                            .size(13).colors(MyColor.slateGray).bold),
                      ),
                    ]),
                  ),
                ),
              ),
              if(state.isShowViewTypeList && state.listBook.isEmpty)
                Utilities.listEmpty(),
              if(state.isShowViewTypeList) ..._listBookView(state)
              else _calenderView(state),
            ]
          );
        }
      );
    }
  }

  Widget _itemHeader() {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        return Row(children: [
          Expanded(child: Text(state.titleCalendar, style: TextStyles.def.semiBold.size(24))),
          _putAside(),
        ]);
      }
    );
  }

  Widget _putAside() {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: ()=> context.read<BookBloc>().add(ChangeViewBookEvent(
            isShowViewTypeList: !state.isShowViewTypeList)
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: MyColor.white,
              borderRadius: BorderRadius.circular(100)
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  const Row(children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(CupertinoIcons.square_grid_2x2, size: 15)
                    ),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(CupertinoIcons.rectangle_grid_1x2, size: 15)
                    ),
                  ]),
                  Row(children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.only(left: state.isShowViewTypeList ? 30 : 0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: MyColor.green,
                      ),
                      child: Center(child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: state.isShowViewTypeList ? const Icon(
                          CupertinoIcons.rectangle_grid_1x2,
                          key: ValueKey('list_view'),
                          color: MyColor.white,
                          size: 15,
                        ) : const Icon(
                          CupertinoIcons.rectangle_grid_2x2,
                          key: ValueKey('grid_view'),
                          color: MyColor.white,
                          size: 15,
                        ),
                      )),
                    )
                  ]),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _loading() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const WidgetShimmer(
          width: double.infinity,
          height: 150,
        ),
        ...List.generate(5, (_) {
          return const Padding(
            padding: EdgeInsets.only(top: 10),
            child: WidgetShimmer(
              width: double.infinity,
              height: 90,
            ),
          );
        })
      ]),
    );
  }

  List<Widget> _listBookView(BookState state) => List.generate(
    state.listBook.length, (index) => WidgetBoxColor(
      closedBot: index == state.listBook.length - 1 ? ClosedEnd.end : null,
      child: GestureDetector(
        onTap: ()=> controller.toDetail(state.listBook[index].id),
        child: WidgetCustomerReservation(
          day: (state.listBook[index].timeBook?.formatUnixTimeToDateDDMMYYYY()).toString(),
          status: WidgetCustomerReservation.decode(state.listBook[index].status),
          avatar: state.listBook[index].avatar ?? "",
          name: state.listBook[index].name ?? "Đang cập nhật",
          numberPhone: state.listBook[index].phone ?? "Đang cập nhật",
          nameService: state.listBook[index].service?.name,
        ),
      )
  ));

  Widget _calenderView(BookState state) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: MyColor.white,
        boxShadow: [BoxShadow(
          color: MyColor.sliver.o5,
          offset: const Offset(0, 5),
          blurRadius: 5
        )],
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TableCalendar(
          locale: 'vi_VN',
          firstDay: DateTime(2000, 1, 1),
          lastDay: DateTime(2100, 12, 31),
          focusedDay: state.focusedDay,
          selectedDayPredicate: (day) => isSameDay(day, state.selectedDay),
          eventLoader: (day) {
            controller.timestamp = DateTime(day.year, day.month, day.day).millisecondsSinceEpoch ~/ 1000;
            controller.normalizedEvents = {
              for (var key in state.events.keys)
                DateTime.fromMillisecondsSinceEpoch(key * 1000)
                    .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
                    .millisecondsSinceEpoch ~/
                    1000: state.events[key]!
            };
            return controller.normalizedEvents[controller.timestamp] ?? [];
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              return Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: events.isNotEmpty ? MyColor.slateBlue : MyColor.slateGray,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AutoSizeText('${events.length > 9 ? "9+" : events.length}',
                    style: TextStyles.def.bold.size(9).colors(MyColor.white),
                    minFontSize: 5,
                    maxLines: 1,
                  )
                ),
              );
            },
          ),
          onPageChanged: (time) {
            context.read<BookBloc>().add(SetTitleCalendarBookEvent(time.formatDateTimeToMothYear));
            context.read<BookBloc>().add(HandleCalenderBookEvent(
              selectedDay: state.selectedDay,
              focusedDay: time,
            ));
          },
          onDaySelected: (selectedDay, focusedDay) {
            int timestamp = DateTime(selectedDay.year, selectedDay.month, selectedDay.day)
                .millisecondsSinceEpoch ~/ 1000;
            Map<int, List<Data>> normalizedEvents = {
              for (var key in state.events.keys)
                DateTime.fromMillisecondsSinceEpoch(key * 1000)
                    .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)
                    .millisecondsSinceEpoch ~/
                    1000: state.events[key]!
            };
            List<Data> listEvent = normalizedEvents[timestamp] ?? [];
            _detailCalendarView(listEvent, selectedDay, focusedDay);
            context.read<BookBloc>().add(HandleCalenderBookEvent(
                selectedDay: selectedDay,
                focusedDay: focusedDay
            ));
          },
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            decoration: BoxDecoration(
              color: MyColor.slateBlue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            titleTextStyle: TextStyle(color: MyColor.white, fontSize: 18),
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
          ),
          calendarStyle: CalendarStyle(
            cellMargin: const EdgeInsets.all(2),
            tablePadding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            defaultDecoration: BoxDecoration(
              border: Border.all(color: MyColor.sliver),
              borderRadius: BorderRadius.circular(7),
            ),
            outsideDaysVisible: false,
            weekendDecoration: BoxDecoration(
              border: Border.all(color: MyColor.red.o3),
              borderRadius: BorderRadius.circular(7),
            ),
            todayDecoration: BoxDecoration(
              color: MyColor.slateBlue.o5,
              border: Border.all(color: MyColor.slateBlue, width: 1.5),
              borderRadius: BorderRadius.circular(7),
            ),
            selectedDecoration: BoxDecoration(
              color: MyColor.slateBlue,
              border: Border.all(color: MyColor.slateBlue),
              borderRadius: BorderRadius.circular(7),
            ),
          ),

        ),
      ),
    );
  }

  void _detailCalendarView(List<Data> listEvent, DateTime selectedDay, DateTime focusedDay) {
    controller.popupBottom(
      child: BlocProvider.value(
        value: context.read<BookBloc>(),
        child: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if(listEvent.isEmpty) {
              return SizedBox(
                width: double.infinity,
                child: Column(children: [
                  Text("Không có lịch hẹn nào trong ngày hôm nay",
                    style: TextStyles.def.colors(MyColor.slateGray).size(12).bold),
                  const Icon(Icons.add, color: MyColor.slateBlue),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      controller.toAddEditBook(time: selectedDay);
                    },
                    child: Text("Thêm lịch hẹn",
                      style: TextStyles.def.colors(MyColor.slateBlue).size(12).bold
                    )
                  )
                ]),
              );
            }
            return SizedBox(
              width: double.infinity,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.7,
                    ),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(selectedDay.formatDateTimeToEEddMM, style: TextStyles.def.size(18).bold),
                          const SizedBox(height: 15),
                          ...List.generate(listEvent.length, (index) {
                            return Material(
                              color: MyColor.nowhere,
                              child: InkWell(
                                onTap: () => controller.toDetail(listEvent[index].id),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(children: [
                                    Text(listEvent[index].timeBook?.formatUnixTimeToHHMM().toString() ?? ""),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Utilities.statusCodeSpaToColor(listEvent[index].status),
                                            shape: BoxShape.circle
                                        ),
                                        child: const SizedBox(height: 10, width: 10),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(listEvent[index].name ?? "Đang cập nhập",
                                              style: TextStyles.def.size(16).semiBold,
                                              maxLines: 1, overflow: TextOverflow.ellipsis),
                                          Text(listEvent[index].services?.name ?? "Đang cập nhập",
                                              style: TextStyles.def,
                                              maxLines: 1, overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Utilities.statusCodeSpaToColor(listEvent[index].status).o2,
                                        borderRadius: BorderRadiusDirectional.circular(5)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                                        child: Text(Utilities.statusCodeSpaToMes(listEvent[index].status),
                                            style: TextStyles.def.size(10).bold.colors(Utilities.statusCodeSpaToColor(listEvent[index].status)),
                                            maxLines: 1, overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward_ios_rounded)
                                  ]),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        ),
      ),
    );
  }

}