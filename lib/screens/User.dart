class User {
  String username, password, phoneNumber, id;
  double monthlyIncome, expenseLimit;
  User(String u, String p, String n) {
    username = u;
    password = p;
    phoneNumber = n;
  }

  User.login(String u, String p) {
    username = u;
    password = p;
  }

  User.profile(
      {this.id,
      this.username,
      this.monthlyIncome,
      this.expenseLimit,
      this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) => _userFromJson(json);
}

User _userFromJson(Map<String, dynamic> json) {

  String username = json['username'] as String;
  String password =json['password'] as String;
  String phoneNumber =json['phoneNumber'] as String;
  return User(username, password, phoneNumber

  );
}
