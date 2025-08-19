class ResCreateMember {
  String? nameSpa;
  String? phone;
  String? email;
  String? address;
  String? password;
  String? passwordAgain;

  ResCreateMember({
    this.nameSpa,
    this.phone,
    this.email,
    this.address,
    this.password,
    this.passwordAgain,
  });

  ResCreateMember.fromJson(Map<String, dynamic> json) {
    nameSpa = json['name_spa'];
    phone = json['phone'].toString();
    email = json['email'];
    address = json['address'];
    password = json['password'];
    passwordAgain = json['password_again'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name_spa': nameSpa,
      'phone': phone,
      'email': email,
      'address': address,
      'password': password,
      'password_again': passwordAgain,
    };
  }
}
