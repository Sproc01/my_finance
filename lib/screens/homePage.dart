import 'package:my_finance/src/Wallet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../src/Transaction.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';
//import 'package:syncfusion_flutter_charts/sparkcharts.dart';

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
            wallet.addTransaction(Transaction.fromString(result as String));
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