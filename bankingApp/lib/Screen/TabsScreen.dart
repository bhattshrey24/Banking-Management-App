import 'AllUsersScreen.dart';
import 'package:flutter/material.dart';
import 'TransferTable.dart';
import './TransferTable.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Basic Banking App'),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              icon: Icon(Icons.people),
              text: 'All Users',
            ),
            Tab(
              icon: Icon(Icons.table_chart),
              text: 'Transfer Table',
            )
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
         
            AllUsersScreen(), 
            TransferTable(),

          ],
        ),
      ),
    );
  }
}
