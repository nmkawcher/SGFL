class PasswordReqModel{
  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  PasswordReqModel({
    this.oldPassword,
    this.newPassword,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    "_method": 'patch', // This is a hidden field in the form, which is used to override the POST method.
    "current_password": oldPassword,
    "new_password": newPassword,
    "new_password_confirmation": confirmPassword,
  };
}