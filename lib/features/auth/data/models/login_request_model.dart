class LoginRequestModel {
  final String username;
  final String password;
  final int expiresInMins;

  LoginRequestModel({
    required this.username,
    required this.password,
    this.expiresInMins = 60,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      username: json['username'],
      password: json['password'],
      expiresInMins: json['expiresInMins'] ?? 60,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'expiresInMins': expiresInMins,
    };
  }
}
