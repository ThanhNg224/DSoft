import 'package:spa_project/base_project/package.dart';

class WidgetCustomerReservation extends StatelessWidget {

  static ReservationStatus decode(int? code) {
    switch (code) {
      case 0: return ReservationStatus.pending;
      case 1: return ReservationStatus.confirmed;
      case 2: return ReservationStatus.noShow;
      case 3: return ReservationStatus.arrived;
      default: return ReservationStatus.cancelled;
    }
  }

  final String day, name, numberPhone;
  final ReservationStatus status;
  final String avatar;
  final String? nameService;
  const WidgetCustomerReservation({
    super.key,
    required this.day,
    required this.status,
    required this.avatar,
    required this.name,
    required this.numberPhone,
    this.nameService
  });

  Color _color(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.pending:
        return MyColor.yellow;
      case ReservationStatus.arrived:
        return MyColor.green;
      case ReservationStatus.cancelled:
        return MyColor.red;
      case ReservationStatus.noShow:
        return MyColor.slateGray;
      case ReservationStatus.confirmed:
        return MyColor.slateBlue;
    }
  }

  String _statusText(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.pending:
        return "CHƯA XÁC NHẬN";
      case ReservationStatus.arrived:
        return "ĐÃ ĐẾN";
      case ReservationStatus.cancelled:
        return "ĐÃ HỦY";
      case ReservationStatus.noShow:
        return "KHÔNG ĐẾN";
      case ReservationStatus.confirmed:
        return "ĐÃ XÁC NHẬN";
      }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColor.nowhere,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          height: 80,
          child: Row(children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: avatar,
                        height: 35, width: 35,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Image.asset(
                            MyImage.avatarNone,
                            height: 35, width: 35,
                            fit: BoxFit.cover
                        ),
                        progressIndicatorBuilder: (context, url, progress) => Image.asset(
                            MyImage.avatarNone,
                            height: 35, width: 35,
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: TextStyles.def.size(13).semiBold, maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(numberPhone, style: TextStyles.def.size(13).semiBold.colors(MyColor.hideText), maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    )
                  ]),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 10),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: _color(status).o2,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                          child: Text(_statusText(status),
                            style: TextStyles.def.size(10).bold.colors(_color(status)),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  )
                ]
              )
            ),
            Expanded(
              flex: 2,
              child: Column(children: [
                Text("Dịch vụ", style: TextStyles.def.size(12).bold),
                Text(nameService ?? "", style: TextStyles.def.size(12).colors(MyColor.hideText)),
                const Spacer(),
                Text(day, style: TextStyles.def.size(12).colors(MyColor.slateGray))
              ])
            )
          ]),
        ),
      )
    );
  }
}
