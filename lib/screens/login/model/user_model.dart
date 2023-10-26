class UserModel {
  final String id, coordinate, email, password, userName;

  UserModel(
      {required this.id,
      required this.coordinate,
      required this.email,
      required this.password,
      required this.userName});

  factory UserModel.fromJson(dynamic data) {
    return UserModel(
        id: data['_id'],
        coordinate: data['coordinate'],
        email: data['email'],
        password: data['password'],
        userName: data['userName']);
  }
}
