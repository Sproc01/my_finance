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
    double totalType = 0;
    for (var transaction in transactions) {
      if (transaction.type == type) {
        totalType += transaction.amount;
      }
    }
    return totalType;
  }

  List<double> percentageIn(){
    double totalOut = 0;
    double totalIn = 0;
    for (var transaction in transactions) {
      if(transaction.type == TypeTransaction.Income){
        totalIn += transaction.amount;
      }
      else{
        totalOut += transaction.amount;
      }
    }
    return [totalIn, totalOut];
  }

  addToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('wallet', Transaction.encode(transactions));
  }
}