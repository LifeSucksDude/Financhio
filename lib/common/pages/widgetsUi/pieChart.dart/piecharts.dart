import 'package:financhio/features/trasactionpages/controller/addtransactionController.dart';
import 'package:financhio/homeview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

final expenseDataListProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  // Replace this with your actual implementation to fetch the data
  return ref.watch(addTransactionProvider).addTransactionRepo.dataForPieChart(selectedBank!);
});

final incomeDataListProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  // Replace this with your actual implementation to fetch the data
 return ref.watch(addTransactionProvider).addTransactionRepo.dataForPieChart(selectedBank!);
});

class PieChartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pie Chart'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Consumer(builder: (context, ref, _) {
              final expenseDataList = ref.watch(expenseDataListProvider);
              return expenseDataList.when(
                data: (data) {
                  return Center(child: buildPieChart(data));
                },
                loading: () => CircularProgressIndicator(),
                error: (error, stackTrace) => Text('Error: $error'),
              );
            }),
            
          
          ],
        ),
      ),
    );
  }

  Widget buildPieChart(List<Map<String, dynamic>> chartData) {
     final List<Color> colorScheme = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

    return SizedBox(
      height: 200,
      width: 200,
      child: PieChart(
        
        PieChartData(
          
          sections: chartData.map((data) {
             final categoryIndex = chartData.indexOf(data) % colorScheme.length;
            return PieChartSectionData(
              value: data['amount'].toDouble(),
              title: '${data['category']}',
              color: colorScheme[categoryIndex],
              radius: 80,
              titleStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}


