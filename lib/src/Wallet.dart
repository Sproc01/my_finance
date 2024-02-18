import 'package:flutter/material.dart';
import 'package:my_finance/src/TypeTransaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Wallet.fromTransactions(List<Transaction> t){
    transactions = t;
  }

  void addTransaction(Transaction transaction){
    transactions.add(transaction);
    transactions.sort((a, b) => -a.date.compareTo(b.date));
    addToSF();
    notifyListeners();
  }

  void removeTransaction(Transaction transaction){
    transactions.remove(transaction);
    addToSF();
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

  addToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('wallet', Transaction.encode(transactions));
  }
}