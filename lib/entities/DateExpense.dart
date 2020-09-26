class DateExpense {

  double total;
  DateTime date;
  DateExpense({this.total, this.date});
  factory DateExpense.fromJson(Map<String, dynamic> json) => _expFromJson(json);

}

DateExpense _expFromJson(Map<String, dynamic> json) {

  return DateExpense(
    total: json['total'].toDouble(),
    date: DateTime.parse(json['date'] as String)
  );
}