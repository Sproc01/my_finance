import 'package:my_finance/src/Transaction.dart';
import 'package:my_finance/src/Wallet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/homePage.dart';
import 'screens/insertPage.dart';
import 'color_schemes.g.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('wallet');
    List<Transaction> t=[];
    if (stringValue != null) {
      t = Transaction.decode(stringValue);
    }
    runApp(
      ChangeNotifierProvider(
        create: (context) => Wallet.fromTransactions(t),
        child: MaterialApp(
          theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          title: 'Named Routes',
          initialRoute: '/',
          routes: {
            '/': (context) => const homePage(),
            '/insertOut/': (context) => insertOutPage(),
          },
      )   
    )
  );
}