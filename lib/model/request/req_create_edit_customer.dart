import 'dart:io';

class ReqCreateEditCustomer {
  final int? id;
  final String? phone;
  final String? name;
  final int? sex;
  final String? email;
  final File? avatar;
  final String? address;
  final int? idGroup;
  final int? source;

  ReqCreateEditCustomer({
    this.id,
    this.phone,
    this.name,
    this.sex,
    this.email,
    this.avatar,
    this.address,
    this.idGroup,
    this.source,
  });

  factory ReqCreateEditCustomer.fromJson(Map<String, dynamic> json) {
    return ReqCreateEditCustomer(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      sex: json['sex'],
      email: json['email'],
      avatar: json['avatar'] != null ? File(json['avatar']) : null,
      address: json['address'],
      idGroup: json['id_group'],
      source: json['source'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
      'sex': sex,
      'email': email,
      'avatar': avatar?.path,
      'address': address,
      'id_group': idGroup,
      'source': source,
    };
  }
}
