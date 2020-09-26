import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class IncomeAmt1 {
  final String date;
  final int amt;
  final charts.Color pieColor;

  IncomeAmt1(
      {@required this.date, @required this.amt, @required this.pieColor});
}
