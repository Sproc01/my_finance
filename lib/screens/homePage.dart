import 'package:my_finance/src/TypeTransaction.dart';
import 'package:my_finance/src/Wallet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../src/Transaction.dart';

// ignore: camel_case_types
class homePage extends StatelessWidget {
  const homePage({super.key});
  static const routename = 'Home';
  
  @override
  Widget build(BuildContext context) {
    var wallet = context.watch<Wallet>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report of Transactions'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 20.0, top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Flexible(
              child: SizedBox(
                height: MediaQuery.of(context).size.height/3,
                child: Card(
                  child: Consumer<Wallet>(
                    builder: (context, wallet, child){
                      List<DataChart> data = [
                          DataChart('Food', wallet.percentageOut(TypeTransaction.Food)),
                          DataChart('Transport', wallet.percentageOut(TypeTransaction.Transport)),
                          DataChart('Shopping', wallet.percentageOut(TypeTransaction.Shopping)),
                          DataChart('Health', wallet.percentageOut(TypeTransaction.Health)),
                          DataChart('Leisure', wallet.percentageOut(TypeTransaction.Leisure)),
                          DataChart('Other', wallet.percentageOut(TypeTransaction.Other)),
                        ];
                      return SfCircularChart(
                        title: const ChartTitle(text: 'Percentage of Transactions'),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        legend: const Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                        series: <CircularSeries<DataChart, String>>[
                          DoughnutSeries<DataChart, String>(
                              dataSource: data,
                              xValueMapper: (DataChart el, _) => el.x,
                              yValueMapper: (DataChart el, _) => el.y,
                              name: 'Chart')
                        ],
                      );
                    }
                  ),
                )
              )
            ),
            Card(
              child: Row(
                children: <Widget>[
                  const Text('Amount available: ', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 40),
                  Consumer<Wallet>(
                    builder: (context, wallet, child)=>Text(wallet.balance.toString(), style: const TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Transactions:', style: TextStyle(fontSize: 20)),
            Expanded(
              child: ListView.builder(
                itemCount: wallet.transactions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(wallet.transactions[index].amount.toString()),
                    subtitle: Text("${wallet.transactions[index].date} ${wallet.transactions[index].type.toString().split('.').last}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red,),
                      onPressed: () {
                        wallet.removeTransaction(wallet.transactions[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],)
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/insertOut/');
          if (result != null) {
            wallet.addTransaction(Transaction.fromJson(result as Map<String, dynamic>));
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Operation canceled')));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DataChart {
  DataChart(this.x, this.y);
  final String x;
  final double y;
}