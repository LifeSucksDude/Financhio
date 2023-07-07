// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'barcharts/barChart.dart';
import 'barcharts/expenseChart.dart';

class PlotScroller extends StatelessWidget {
  String period;
  String bankName;
  PlotScroller({
    Key? key,
    required this.period,
    required this.bankName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      
      child: Container(
      //  margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
       
     
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              BarChartWidget(period:period,bankName:bankName),
              BarNewChartWidget(period:period,bankName:bankName)
          ]),
        ),
      )

    ;
  }
}
