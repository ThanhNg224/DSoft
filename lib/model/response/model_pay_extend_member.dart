class ModelPayExtendMember {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelPayExtendMember({this.data, this.code, this.messages, this.totalData});

  ModelPayExtendMember.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
    messages = json['messages'];
    totalData = json['totalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    data['messages'] = messages;
    data['totalData'] = totalData;
    return data;
  }
}

class Data {
  String? numberBank;
  String? accountName;
  String? codeBank;
  String? content;
  int? amount;
  String? nameBank;
  String? linkQR;

  Data(
      {this.numberBank,
        this.accountName,
        this.codeBank,
        this.content,
        this.amount,
        this.nameBank,
        this.linkQR});

  Data.fromJson(Map<String, dynamic> json) {
    numberBank = json['number_bank'];
    accountName = json['accountName'];
    codeBank = json['code_bank'];
    content = json['content'];
    amount = json['amount'];
    nameBank = json['name_bank'];
    linkQR = json['linkQR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number_bank'] = numberBank;
    data['accountName'] = accountName;
    data['code_bank'] = codeBank;
    data['content'] = content;
    data['amount'] = amount;
    data['name_bank'] = nameBank;
    data['linkQR'] = linkQR;
    return data;
  }
}
