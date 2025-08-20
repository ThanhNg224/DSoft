import 'dart:math';
import 'dart:ui';
import 'package:spa_project/base_project/package.dart';

class WidgetDropDow<T> extends StatelessWidget {
  final String title, validate;
  final String? topTitle;
  final List<WidgetDropSpan> content;
  final T? value;
  final String Function(T) getValue;
  final void Function(T) onSelect;
  final bool tick;
  final VoidCallback? onCreate;
  final bool enableSearch;
  WidgetDropDow({super.key,
    required this.title,
    this.topTitle,
    this.validate = "",
    required this.content,
    this.value,
    required this.getValue,
    required this.onSelect,
    this.tick = false,
    this.onCreate,
    this.enableSearch = false
  });

  final GlobalKey _kSizeWith = GlobalKey();
  final GlobalKey _contentKey = GlobalKey();

  void _drop(BuildContext context) {
    final RenderBox? renderBox =
    _kSizeWith.currentContext?.findRenderObject() as RenderBox?;
    final double width = renderBox?.size.width ?? 0;
    final double height = renderBox?.size.height ?? 0;
    final Offset offset = renderBox?.localToGlobal(Offset.zero) as Offset;

    final RenderBox? fFenderBox = _contentKey.currentContext?.findRenderObject() as RenderBox?;
    final double contentHeight = fFenderBox?.size.height ?? 0;

    Utilities.dismissKeyboard();
    Navigator.push(context, PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, _, __) {
          return _WidgetDrop(
            widthItem: width,
            offset: offset,
            heightItem: height,
            content: content,
            titleDrop: title,
            contentHeight: contentHeight,
            topTitle: topTitle ?? "",
            getValue: getValue,
            valueName: value,
            onSelect: onSelect,
            onCreate: onCreate,
            hasSearch: enableSearch,
          );
        })
    );
  }

  static Widget button({
    required String name,
    bool? isChosen = false,
    required void Function(String) onSelect
  }) => Material(
      color: isChosen! ? MyColor.sliver : MyColor.nowhere,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: ()=> onSelect(name),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            children: [
              Expanded(child: Text(name, style: isChosen ? TextStyles.def.bold : TextStyles.def)),
              if(isChosen) const Icon(Icons.check, color: MyColor.green)
            ],
          ),
        ),
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Column(
      key: _kSizeWith,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if(topTitle != null && (topTitle??'').isNotEmpty) Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(children: [
            Text(topTitle??'', style: TextStyles.def),
            const SizedBox(width: 5),
            if(tick) Text("*", style: TextStyles.def.colors(MyColor.red).size(18))
          ]),
        ),
        GestureDetector(
          onTap: ()=> _drop(context),
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: validate.isEmpty ? MyColor.borderInput : MyColor.red),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
              child: Row(children: [
                Expanded(child: Text(displayText(),
                    style: TextStyles.def.colors(colorText()),
                    maxLines: 1, overflow: TextOverflow.ellipsis
                )),
                const SizedBox(width: 10),
                const Icon(Icons.expand_more_outlined)
              ]),
            ),
          ),
        ),
        Offstage(
          child: ColoredBox(
            color: MyColor.red,
            child: Column(
              key: _contentKey,
              mainAxisSize: MainAxisSize.min,
              children: [
                if(content.isEmpty)
                  const SizedBox(height: 20)
                else ...content.map((item) {
                  if (item.isCategory) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        getValue(item.value).toUpperCase(),
                        style: TextStyles.def.bold,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20 + 10, vertical: 15),
                    child: Text(
                      getValue(item.value),
                      style: TextStyles.def.bold,
                    ),
                  );
                }),
                const SizedBox(height: 20),
              ]
            ),
          ),
        ),
      ],
    );
  }

  Color colorText() {
    if(validate.isEmpty) {
      return value == null ? MyColor.hideText : MyColor.darkNavy;
    } else {
      return MyColor.red;
    }
  }

  String displayText() {
    String result;
    if (value != null) {
      result = getValue(value as T);
    } else {
      result = validate.isEmpty ? title : validate;
    }
    return result;
  }

}

class _WidgetDrop<T> extends StatefulWidget {
  final double widthItem, heightItem, contentHeight;
  final Offset offset;
  final List<WidgetDropSpan> content;
  final String titleDrop;
  final String topTitle;
  final T? valueName;
  final String Function(T) getValue;
  final void Function(T) onSelect;
  final VoidCallback? onCreate;
  final bool hasSearch;
  const _WidgetDrop({
    required this.widthItem,
    required this.heightItem,
    required this.offset,
    required this.content,
    required this.titleDrop,
    required this.contentHeight,
    required this.topTitle,
    required this.getValue,
    required this.valueName,
    required this.onSelect,
    this.onCreate,
    this.hasSearch = false
  });

  @override
  State<_WidgetDrop<T>> createState() => _WidgetDropState<T>();
}

class _WidgetDropState<T> extends State<_WidgetDrop<T>> {
  final TextEditingController _searchController = TextEditingController();
  List<WidgetDropSpan> _filteredContent = [];
  final GlobalKey _dropKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _filteredContent = widget.content;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContent = widget.content.where((item) {
        if (item.isCategory) return true;
        final itemText = widget.getValue(item.value).toLowerCase();
        return itemText.contains(query);
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double spaceBelow = screenHeight - widget.offset.dy - widget.heightItem;
    final finalHeightItem = min(widget.heightItem + widget.contentHeight, 400);
    final bool showAbove = spaceBelow < finalHeightItem;

    double offsetDy = !showAbove ? widget.offset.dy + widget.heightItem : max(widget.offset.dy - finalHeightItem, 50);

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: MyColor.darkNavy.o1,
        body: TweenAnimationBuilder(
          tween: Tween<double>(
            begin: MediaQuery.of(context).viewInsets.bottom > 0 ? 50 : offsetDy,
            end: MediaQuery.of(context).viewInsets.bottom > 0 ? 50 : offsetDy,
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastEaseInToSlowEaseOut,
          builder: (context, value, _) {
            return Transform.translate(
              offset: Offset(widget.offset.dx, value),
              child: _itemDrop(finalHeightItem.toDouble(), showAbove, context),
            );
          }
        ),
      ),
    );

  }

  Widget _itemDrop(double maxHeight, bool showAbove, BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastEaseInToSlowEaseOut,
      tween: Tween<double>(begin: 0.6, end: 1),
      builder: (context, value, _) {
        return Transform.scale(
          scale: value,
          alignment: !showAbove ? Alignment.topCenter : Alignment.bottomCenter,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaY: 100 - (value * 100),
              sigmaX: 100 - (value * 100),
              tileMode: TileMode.decal
            ),
            child: Container(
              key: _dropKey,
              width: widget.widthItem,
              clipBehavior: Clip.antiAlias,
              constraints: BoxConstraints(maxHeight: maxHeight + sizeInputSearch),
              decoration: BoxDecoration(
                color: MyColor.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(
                  color: MyColor.slateGray.o1,
                  blurRadius: 20,
                )],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                children: [
                                  Expanded(child: Text(widget.titleDrop.isEmpty ? "Lựa chọn" : widget.titleDrop,
                                    style: TextStyles.def.bold.size(16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  if(widget.onCreate != null) GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      widget.onCreate!();
                                    },
                                    child: const Icon(Icons.add, color: MyColor.slateBlue)
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if(widget.hasSearch) _inputSearch(),
                        SizedBox(
                          height: min(widget.contentHeight, 345),
                          child: _filteredContent.isEmpty ? Align(
                            alignment: Alignment.topCenter,
                            child: Text("Không có bản ghi nào", style: TextStyles.def.colors(MyColor.hideText).size(13))
                          ) : ListView.builder(
                            physics: Utilities.defaultScroll,
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            itemCount: _filteredContent.length,
                            itemBuilder: (context, index) {
                              if (_filteredContent[index].isCategory) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    widget.getValue(_filteredContent[index].value).toUpperCase(),
                                    style: TextStyles.def.bold,
                                  ),
                                );
                              } else {
                                return WidgetDropDow.button(
                                  name: widget.getValue(_filteredContent[index].value),
                                  isChosen: widget.valueName != null && widget.getValue(_filteredContent[index].value) == widget.getValue(widget.valueName as T),
                                  onSelect: (p0) {
                                    Navigator.pop(context);
                                    widget.onSelect(_filteredContent[index].value);
                                  },
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _inputSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
      child: SizedBox(
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: MyColor.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyColor.borderInput, width: 1.0)
          ),
          child: Center(
            child: TextField(
              cursorColor: MyColor.slateBlue,
              controller: _searchController,
              onChanged: (value) {

              },
              decoration: InputDecoration(
                  isDense: true,
                  counterText: '',
                  contentPadding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
                  hintStyle: TextStyles.def.colors(MyColor.hideText).regular,
                  hintText: "Tìm kiếm",
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search, color: MyColor.hideText)
              ),
            ),
          ),
        ),
      ),
    );
  }

  double get sizeInputSearch => 50;

  @override
  void didUpdateWidget(_WidgetDrop<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.content != widget.content) {
      _onSearchChanged();
    }
  }
}

class WidgetDropSpan<T> {
  T value;
  bool isCategory;

  WidgetDropSpan({required this.value, this.isCategory = false});
}
