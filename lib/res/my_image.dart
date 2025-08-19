class MyImage {
  static String _baseLinkFileIcon(String endPoint) => "assets/icon/$endPoint";
  static String _baseLinkFileImg(String endPoint) => "assets/image/$endPoint";

  static String iconFavourite = _baseLinkFileIcon("icon_favourite.png");
  static String iconFilter = _baseLinkFileIcon("icon_filter.svg");
  static String avatarNone = _baseLinkFileImg("avatar_none.png");
  static String imgNoteNowDate = _baseLinkFileImg("img_note_now_date.png");
  static String imgNoteSelectDate = _baseLinkFileImg("img_note_select_date.png");
  static String notInternet = _baseLinkFileImg("not_internet.svg");
  static String noInternet = _baseLinkFileImg("no_internet.png");
  static String doublePerson = _baseLinkFileIcon("icon_double_person.svg");
  static String iconIncrease = _baseLinkFileIcon("icon_increase.svg");
  static String iconReduce = _baseLinkFileIcon("icon_reduce.svg");
  static String iconZalo = _baseLinkFileIcon("icon_zalo.png");
  static String noImage = _baseLinkFileImg("no_image.jpg");
  static String iconMenu = _baseLinkFileIcon("icon_menu.svg");
  static String iconPayment = _baseLinkFileIcon("icon_payment.svg");
  static String boxEmpty = _baseLinkFileImg("box_empty.svg");
}