// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:financhio/Theme/pallete.dart';
import 'package:financhio/models/bankModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/trasactionpages/controller/addtransactionController.dart';
import '../../../../models/transaction.dart';

class BarChartWidget extends ConsumerWidget {
  final String period;
  final String bankName;
  const BarChartWidget({
    required this.bankName,
    Key? key,
    required this.period,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(builder: (context) {
      return StreamBuilder(
          stream:
              ref.watch(addTransactionProvider).QueryListGen(period, bankName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox();
            }

            List<TransactionModel>? data = snapshot.data;
            List<DateTime> x = []; // List to store x-axis values
            List<double> y = [];
         
            // Process the data and populate x and y lists
            if (data != null) {
              for (var transaction in data) {
                // Add data to x and y lists based on your requirements
                // For example, if you want to show amount on y-axis and date on x-axis:
                DateTime date = DateTime.parse(transaction.datetime);
                if (transaction.type == "Income") {
                  x.add(date);
                  // Add the date to x-axis list
                  y.add(transaction.amount); // Add the amount to y-axis list
                } 
              }
            }

            return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Container(
                    height: 185,
                    width: 380,
                    decoration: BoxDecoration(color: Pallete.whiteColor),
                    child: BarChart(BarChartData(
                         
                        barGroups: List.generate(
                          
                            x.length,
                            (index) { 
                              return
                              BarChartGroupData(x: index, barRods: [
                                  BarChartRodData(
                                      toY: y[index], color: Pallete.greenColor)
                                ],
                                
                                );}
                                )

                                )
                                )
                                )
                                );
          });
    });
  }
}
