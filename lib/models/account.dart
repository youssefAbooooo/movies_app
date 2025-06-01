class Account {
  final int id;
  final String username;

  Account({required this.id, required this.username});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['account_id'],
      username: json['username'],
    );
  }
}
