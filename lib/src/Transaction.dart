import "package:my_finance/src/TypeTransaction.dart";

class Transaction
{
  late int id;
  double amount;
  DateTime date;
  static int counter = 0;
  TypeTransaction? type;

  Transaction(this.amount, this.date, [this.type])
  {
    counter=counter+1;
    id=counter;
  }

  Transaction.fromString(String s)
      : amount = 0,
        date = DateTime.now() {
    var parts = s.split('|');
    id = int.parse(parts[0]);
    amount = double.parse(parts[1]);
    date = DateTime.parse(parts[2]);
    String val=parts[3].split('.').last;
    switch(val)
    {
      case "Food":
        type=TypeTransaction.Food;
        break;
      case "Transport":
        type=TypeTransaction.Transport;
        break;
      case "Shopping":
        type=TypeTransaction.Shopping;
        break;
      case "Health":
        type=TypeTransaction.Health;
        break;
      case "Leisure":
        type=TypeTransaction.Leisure;
        break;
      case "Other":
        type=TypeTransaction.Other;
        break;
      case "Income":
        type=TypeTransaction.Income;
        break;
    }
  }

  @override
  String toString() {
    return "$id|$amount|$date|$type";
  }
}