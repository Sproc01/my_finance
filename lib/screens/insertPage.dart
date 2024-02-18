import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_finance/src/transaction.dart';
import 'package:my_finance/src/TypeTransaction.dart';

int dropdownValue = 0;
const listGlobal = TypeTransaction.values;

// ignore: camel_case_types
class insertOutPage extends StatelessWidget {
  insertOutPage({Key? key}) :
  super(key: key);
  static const routename = 'Insert Transaction';
  final myController = TextEditingController();
  final dateController = TextEditingController();

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
                  icon: Icon(Icons.attach_money),
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
            TextField(
              controller: dateController, //editing controller of this TextField
              decoration: const InputDecoration( 
                icon: Icon(Icons.calendar_today), //icon of text field
                labelText: "Enter Date" //label text of field
              ),
              readOnly: true,  // when true user cannot edit text 
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), //get today's date
                    firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101)
                );
                if(pickedDate != null){
                    String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    //below line adds the date to the controller
                    dateController.text = formattedDate;
                }
              },
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
                  t = Transaction(double.parse(myController.text), DateTime.parse(dateController.text), listGlobal[dropdownValue]);
                }
                else{
                  t = Transaction(-double.parse(myController.text), DateTime.parse(dateController.text), listGlobal[dropdownValue]);
                }
                Navigator.pop(context, Transaction.toMap(t));
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
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(textBaseline: TextBaseline.alphabetic, fontSize: 20),
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
