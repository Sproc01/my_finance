import 'package:flutter/material.dart';
import 'package:my_finance/src/TypeTransaction.dart';
import 'Transaction.dart';

class Wallet extends ChangeNotifier
{
  List<Transaction> transactions=[];
  double get balance{
    double balance = 0;
    for (var transaction in transactions) {
      balance += transaction.amount;
    }
    return balance;
  }

  Wallet();

  factory Wallet.fromJson(Map<String, dynamic> jsonData) {
    Wallet w=Wallet();
    w.transactions = Transaction.decode(jsonData['transactions']);
    return w;
  }

  static Map<String, dynamic> toMap(Wallet t) => {
    'transactions': Transaction.encode(t.transactions),
  };

  void addTransaction(Transaction transaction){
    transactions.add(transaction);
    notifyListeners();
  }

  void removeTransaction(Transaction transaction){
    transactions.remove(transaction);
    notifyListeners();
  }

  double percentageOut(TypeTransaction type){
    double total = 0;
    double totalType = 0;
    for (var transaction in transactions) {
      if(transaction.type != TypeTransaction.Income){
        total += transaction.amount;
      }
      if (transaction.type == type) {
        totalType += transaction.amount;
      }
    }
    return -1*totalType/total*100;
  }
}