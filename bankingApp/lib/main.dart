import 'package:bankingApp/Screen/UserInputForm.dart';
import 'package:bankingApp/provider/UserProvider.dart';

import './Screen/AllUsersScreen.dart';
import 'Screen/TransferTable.dart';
import './Screen/TabsScreen.dart';
import './Screen/UserScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserProvider(),
      child: MaterialApp(
        title: 'Credit App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(),
          TransferTable.routeName: (ctx) => TransferTable(),
          AllUsersScreen.routeName: (ctx) => AllUsersScreen(),
          UserScreen.routeName: (ctx) => UserScreen(),
          UserInputForm.routeName: (ctx) => UserInputForm()
        },
        
      ),
    );
  }
}
