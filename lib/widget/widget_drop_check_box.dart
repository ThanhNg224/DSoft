import 'package:spa_project/base_project/package.dart';

class WidgetDropItem<T> {
  T value;
  bool isCheck;

  WidgetDropItem({required this.value, required this.isCheck});
}

class WidgetDropCheckBoxCubit<T> extends Cubit<List<WidgetDropItem<T>>> {
  final Function(List<T>)? onChanged;

  WidgetDropCheckBoxCubit({
    List<WidgetDropItem<T>> items = const [],
    this.onChanged,
  }) : super(items);

  void toggleCheck(int index) {
    final newItems = List<WidgetDropItem<T>>.from(state);
    newItems[index] = WidgetDropItem<T>(
      value: newItems[index].value,
      isCheck: !newItems[index].isCheck,
    );
    emit(newItems);
    onChanged?.call(_getCheckedValues());
  }

  void toggleAll(bool checkAll) {
    final newItems = state.map((item) => WidgetDropItem<T>(
      value: item.value,
      isCheck: checkAll,
    )).toList();
    emit(newItems);
    onChanged?.call(_getCheckedValues());
  }

  List<T> _getCheckedValues() {
    return state.where((e) => e.isCheck).map((e) => e.value).toList();
  }

  bool get allChecked => state.every((item) => item.isCheck);

  bool get anyChecked => state.any((item) => item.isCheck);
}

class WidgetDropCheckBox<T> extends StatelessWidget {
  final List<WidgetDropItem<T>> children;
  final String? title;
  final Function(List<T>) onChanged;
  final String Function(T)? getLabel;
  final bool isExpanded;

  const WidgetDropCheckBox({
    super.key,
    required this.children,
    required this.onChanged,
    required this.isExpanded,
    this.getLabel,
    this.title = "",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && title!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: MyColor.borderInput,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(child: Text(title ?? "", style: TextStyles.def.colors(MyColor.slateGray))),
                      if (isExpanded)
                        WidgetCheckbox(
                          value: children.every((item) => item.isCheck),
                          onChanged: (value) {
                            final updated = children.map((e) => WidgetDropItem<T>(
                              value: e.value,
                              isCheck: value ?? false,
                            )).toList();
                            onChanged(updated
                                .where((e) => e.isCheck)
                                .map((e) => e.value)
                                .toList());
                          },
                        )
                      else
                        const Icon(Icons.add, color: MyColor.slateGray)
                    ],
                  ),
                ),
              ),
            ),
          AnimatedSize(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            alignment: Alignment.centerLeft,
            child: isExpanded ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(children.length, (index) {
                final item = children[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    child: WidgetCheckbox(
                      value: item.isCheck,
                      title: getLabel?.call(item.value) ?? item.value.toString(),
                      onChanged: (val) {
                        final updated = [...children];
                        updated[index] = WidgetDropItem<T>(
                          value: item.value,
                          isCheck: val ?? false,
                        );
                        onChanged(updated
                            .where((e) => e.isCheck)
                            .map((e) => e.value)
                            .toList());
                      },
                    ),
                  ),
                );
              }),
            ) : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}


