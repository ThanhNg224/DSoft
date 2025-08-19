import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_search_customer.dart';
import 'package:spa_project/model/response/model_list_customer.dart';
import 'package:spa_project/view/book_add_edit/bloc/view_search_cubit.dart';

class ViewSearchCustomer extends StatefulWidget {
  final bool isLimitedByRegion;
  const ViewSearchCustomer({super.key, required this.isLimitedByRegion});

  @override
  State<ViewSearchCustomer> createState() => _ViewSearchCustomerState();
}

class _ViewSearchCustomerState extends State<ViewSearchCustomer> {

  late _ViewSearchCustomerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _ViewSearchCustomerController(context);
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller._focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller._focusNode.dispose();
    _controller._searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: const WidgetAppBar(title: 'Tìm kiếm khách hàng'),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(20),
          physics: Utilities.defaultScroll,
          child: BlocBuilder<ViewSearchCubit, ViewSearchState>(
            builder: (context, state) {
              return WidgetBoxColor(
                closed: ClosedEnd.start,
                closedBot: ClosedEnd.end,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetInput(
                      controller: _controller._searchController,
                      focusNode: _controller._focusNode,
                      suffixIcon: const Icon(Icons.search),
                      hintText: "Tìm kiếm",
                      onChange: (value) => _controller.getListCustomer(value)
                    ),
                    const SizedBox(height: 20),
                    if(!widget.isLimitedByRegion && _controller._searchController.text.isNotEmpty && state.listSearch.isEmpty) Center(
                      child: SizedBox(
                        width: 100,
                        child: WidgetButton(
                          title: "Đồng ý",
                          radius: 100,
                          vertical: 5,
                          styleTitle: TextStyles.def.colors(MyColor.white),
                          onTap: () {
                            Utilities.dismissKeyboard();
                            Navigator.pop(context, ModelSearchCustomer(
                              name: _controller._searchController.text,
                            ));
                          },
                        ),
                      ),
                    ) else ...List.generate(state.listSearch.length, (index) {
                      return _button(state, index);
                    }),
                    if(state.isLoading) const WidgetLoading()
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  Widget _button(ViewSearchState state, int index) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: MyColor.nowhere,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            Utilities.dismissKeyboard();
            Navigator.pop(context, ModelSearchCustomer(
              id: state.listSearch[index].id,
              name: state.listSearch[index].name,
              phone: state.listSearch[index].phone,
              email: state.listSearch[index].email,
            ));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(state.listSearch[index].name ?? ""),
          ),
        ),
      ),
    );
  }
}

class _ViewSearchCustomerController with Repository {
  BuildContext context;
  _ViewSearchCustomerController(this.context);

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  Widget errorWidget = const SizedBox();

  void getListCustomer(String value) async {
    _onSetLoading(true);
    final res = await searchCustomersApi(value);
    if(res is Success<ModelListCustomer>) {
      if(res.value.code == Result.isOk) {
        _onSetLoading(false);
        _onSuccess(res.value.data ?? []);
      } else {
        _onSetLoading(false);
        errorWidget = Utilities.errorMesWidget("Đã có lỗi xảy ra!");
      }
    }
    if(res is Failure<ModelListCustomer>) {
      _onSetLoading(false);
      errorWidget = Utilities.errorCodeWidget(res.errorCode);
    }
  }

  void _onSuccess(List<Data> listSearch) {
    context.read<ViewSearchCubit>().getListSearch(listSearch);
  }

  void _onSetLoading(bool value) {
    context.read<ViewSearchCubit>().setLoading(value);
  }
}
