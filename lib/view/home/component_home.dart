import 'package:spa_project/base_project/package.dart';

class ComponentHome {

  static Widget loadBusinessReport() {
    return WidgetBoxColor(
      closed: ClosedEnd.start,
      closedBot: ClosedEnd.end,
      child: Column(children: [
        const WidgetShimmer(height: 90, width: double.infinity),
        const SizedBox(height: 20),
        const Row(children: [
          Expanded(child: WidgetShimmer(height: 90)),
          SizedBox(width: 10),
          Expanded(child: WidgetShimmer(height: 90)),
        ]),
        const SizedBox(height: 10),
        const Row(children: [
          Expanded(child: WidgetShimmer(height: 90)),
          SizedBox(width: 10),
          Expanded(child: WidgetShimmer(height: 90)),
        ]),
        ...List.generate(3, (_) {
          return const Padding(
            padding: EdgeInsets.only(top: 10),
            child: WidgetShimmer(
              height: 100,
              width: double.infinity,
            ),
          );
        })
      ]),
    );
  }

  static Widget loadBilStatistical() {
    return IntrinsicHeight(
      child: WidgetBoxColor(
        closed: ClosedEnd.start,
        closedBot: ClosedEnd.end,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(text: TextSpan(
            children: [
              TextSpan(
                  text: "Tổng doanh thu:   ",
                  style: TextStyles.def.size(16)
              ),
              const WidgetSpan(child: SizedBox(
                height: 14, width: 14,
                child: CircularProgressIndicator(
                  color: MyColor.slateBlue,
                  strokeWidth: 1.5,
                ),
              ))
            ]
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(children: [
              const ClipOval(
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: ColoredBox(color: MyColor.slateBlue),
                ),
              ),
              Expanded(child: Text("  Biểu thị 1", style: TextStyles.def.size(10).bold))
            ]),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: MyColor.borderInput, width: 1.5)
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(children: [
                Expanded(flex: 2, child: WidgetShimmer(height: 25)),
                Spacer(flex: 1),
                Icon(Icons.calendar_today_outlined, size: 18)
              ]),
            ),
          ),
          const SizedBox(height: 17),
          const AspectRatio(
            aspectRatio: 1,
            child: WidgetShimmer(),
          ),
          const SizedBox(height: 20),
          DecoratedBox(
            decoration: BoxDecoration(
                color: MyColor.green,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 18),
              child: Row(children: [
                const SizedBox(
                  height: 14, width: 14,
                  child: CircularProgressIndicator(
                    color: MyColor.white,
                    strokeWidth: 1.5,
                  ),
                ),
                Expanded(
                    child: Text("0", style: TextStyles.def.bold.colors(MyColor.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    )
                ),
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
