class ReqChangePassModel {
  String? currentPassword;
  String? newPassword;
  String? passwordConfirmation;
  String? tokenDevice;

  ReqChangePassModel(
      {this.currentPassword,
        this.newPassword,
        this.passwordConfirmation,
        this.tokenDevice});

  ReqChangePassModel.fromJson(Map<String, dynamic> json) {
    currentPassword = json['current_password'];
    newPassword = json['new_password'];
    passwordConfirmation = json['password_confirmation'];
    tokenDevice = json['token_device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_password'] = currentPassword;
    data['new_password'] = newPassword;
    data['password_confirmation'] = passwordConfirmation;
    data['token_device'] = tokenDevice;
    return data;
  }
}
