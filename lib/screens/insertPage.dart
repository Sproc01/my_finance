import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myFinance/src/transaction.dart';
import 'package:myFinance/src/TypeTransaction.dart';

int dropdownValue = 0;
const listGlobal = TypeTransaction.values;

class insertOutPage extends StatelessWidget {
  insertOutPage({Key? key}) :
  super(key: key);
  static const routename = 'Insert Transaction';
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(insertOutPage.routename),
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 20.0, top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          children: <Widget>[
            const Text('Insert Amount: '),
            const SizedBox(height: 20),
            TextField(
                controller: myController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                ),
                maxLines: 1,       
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false
                  ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                autofocus: true,
            ),
            const SizedBox(height: 20),
            const Row(
              children: <Widget>[
                Text('Type of Transaction: ', style: TextStyle(fontSize: 20)),
                SizedBox(width: 20),
                DropdownButtonTransaction(),
              ],
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed:(){
                if (myController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please insert an amount'),
                    ),
                  );
                  return;
                }
                Transaction t;
                if (listGlobal[dropdownValue].toString().split('.').last == "Income") {
                  t = Transaction(double.parse(myController.text), DateTime.now(), listGlobal[dropdownValue]);
                }
                else
                {
                  t = Transaction(-double.parse(myController.text), DateTime.now(), listGlobal[dropdownValue]);
                }
                Navigator.pop(context, t.toString());
              },
              child: const Text('Insert Transaction'),
            ),
          ],
        ),
      ), 
    );
  }
}

class DropdownButtonTransaction extends StatefulWidget {
  const DropdownButtonTransaction({super.key});

  @override
  State<DropdownButtonTransaction> createState() =>_DropdownButtonTransactionState();
}

class _DropdownButtonTransactionState extends State<DropdownButtonTransaction> {

  @override
  Widget build(BuildContext context) {
    List<String> list = valueTypeTransaction();
    return DropdownButton<String>(
      value: list[dropdownValue],
      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
      elevation: 16,
      underline: Container(
        height: 5,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = list.indexOf(value!);
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
