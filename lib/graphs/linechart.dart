import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class IncomeAmt2 {
  final String date;
  final int amt;
  final charts.Color lineColor;

  IncomeAmt2(
      {@required this.date, @required this.amt, @required this.lineColor});
}
