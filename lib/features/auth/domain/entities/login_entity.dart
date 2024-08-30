

class LoginEntity {
  final String username;
  final String password;
  final int expiresInMins;


  LoginEntity(
      {
        required this.username,
        required this.password,
        this.expiresInMins = 60,

      });
}
