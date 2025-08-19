class ModelPaymentMethod {
  String name;
  String? keyValue;

  ModelPaymentMethod({
    this.name = "",
    this.keyValue
  });

  static List<ModelPaymentMethod> listPaymentMethod = [
    ModelPaymentMethod(name: "Tiền mặt", keyValue: "tien_mat"),
    ModelPaymentMethod(name: "Chuyển khoản", keyValue: "chuyen_khoan"),
    ModelPaymentMethod(name: "Quẹt thẻ", keyValue: "the_tin_dung"),
    ModelPaymentMethod(name: "Ví điện tử", keyValue: "vi_dien_tu"),
    ModelPaymentMethod(name: "Công nợ", keyValue: "cong_no"),
    ModelPaymentMethod(name: "Thẻ trả trưởc", keyValue: "the_tra_truoc "),
    ModelPaymentMethod(name: "Hình thức khác", keyValue: "hinh_thuc_khac "),
  ];

  static String getNameByKey(String? key) {
    return listPaymentMethod.firstWhere((e) => e.keyValue?.trim() == key?.trim(),
      orElse: () => ModelPaymentMethod(name: "Không xác định"),
    ).name;
  }

}