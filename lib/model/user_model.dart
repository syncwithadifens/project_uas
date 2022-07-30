class UserModel {
  String name;
  String email;
  String password;
  String passwordConfirmation;
  String address;

  UserModel({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
      address: json['address'],
    );
  }
}
