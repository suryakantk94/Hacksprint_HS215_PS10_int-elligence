import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class IncomePie extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  IncomePie(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory IncomePie.withSampleData() {
    return new IncomePie(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Add an [ArcLabelDecorator] configured to render labels outside of the
        // arc with a leader line.
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside)
        ]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<IncomeData, String>> _createSampleData() {
    final data = [
      new IncomeData("30 June", 100),
      new IncomeData("1 July", 75),
      new IncomeData("2 July", 25),
      new IncomeData("3 July", 5),
      new IncomeData("4 July", 5),
      new IncomeData("5 July", 5),
      new IncomeData("6 July", 5),
    ];

    return [
      new charts.Series<IncomeData, String>(
        id: 'Sales',
        domainFn: (IncomeData sales, _) => sales.date,
        measureFn: (IncomeData sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (IncomeData row, _) => '${row.date}: ${row.sales}',
      )
    ];
  }
}

/// Sample linear data type.
class IncomeData {
  final String date;
  final int sales;

  IncomeData(this.date, this.sales);
}
