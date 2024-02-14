import 'package:my_finance/src/Wallet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/homePage.dart';
import 'screens/insertPage.dart';
import 'color_schemes.g.dart';

void main() {
    runApp(
      ChangeNotifierProvider(
      create: (context) => Wallet(),
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