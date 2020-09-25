class User {
  String username, password, phoneNumber, id;
  double monthlyIncome, dailyLimit, savings;
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
      this.dailyLimit,
        this.savings,
      this.phoneNumber });

  factory User.fromJson(Map<String, dynamic> json) => _userFromJson(json);
}

User _userFromJson(Map<String, dynamic> json) {

  return User.profile(
      id: json['_id'] as String,
      username: json['username'] as String,
      monthlyIncome: json['monthlyIncome'].toDouble(),
      dailyLimit: json['dailyLimit'].toDouble(),
      savings: json['saving'].toDouble(),
      phoneNumber: json['phoneNumber'] as String,

     );
}
