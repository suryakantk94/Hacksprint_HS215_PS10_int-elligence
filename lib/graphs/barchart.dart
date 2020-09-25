import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class IncomeAmt {
  final String date;
  final int amt;
  final charts.Color barColor;

  IncomeAmt({@required this.date, @required this.amt, @required this.barColor});
}
