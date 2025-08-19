class ReqChangeMyInfo {
  final String? nameSpa;
  final String? phone;
  final String? email;
  final String? address;
  final String? avatar;

  ReqChangeMyInfo({
    this.nameSpa,
    this.phone,
    this.email,
    this.address,
    this.avatar,
  });

  factory ReqChangeMyInfo.fromJson(Map<String, dynamic> json) {
    return ReqChangeMyInfo(
      nameSpa: json['name_spa'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name_spa': nameSpa,
      'phone': phone,
      'email': email,
      'address': address,
      'avatar': avatar,
    };
  }

  ReqChangeMyInfo copyWith({
    String? nameSpa,
    String? phone,
    String? email,
    String? address,
    String? avatar,
  }) {
    return ReqChangeMyInfo(
      nameSpa: nameSpa ?? this.nameSpa,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
    );
  }
}

