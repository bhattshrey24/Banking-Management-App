import 'package:bankingApp/Model/TransferStructure.dart';
import 'package:flutter/material.dart';
import '../Model/UserStructure.dart';
import '../helper/dbHelper.dart';

class UserProvider with ChangeNotifier {
  List<User> _list = [];

  List<User> get list {
    return [..._list];
  }

  List<Transfer> _transferList = [];

  List<Transfer> get transferList {
    return [..._transferList];
  }

  Future<void> addUser(User _user) async {
    await AppDB.insert('User_Details', {
      'name': _user.name,
      'email': _user.email,
      'credit': _user.credit
    }).then((value) => fetchAndSet());
    notifyListeners();
  }

  Future<void> addTransaction(Transfer _txn) async {
    await AppDB.insert('Transfer_Table', {
      'transferFrom': _txn.transferFrom,
      'transferTo': _txn.transferTo,
      'transferAmount': _txn.transferAmount
    }).then((value) => fetchAndSetTransfer());
    notifyListeners();
  }

  Future<void> fetchAndSet() async {
   
    print('inside fetch and set');
    final dbList = await AppDB.getData('User_Details');

   
    _list = dbList.map((student) {
      return User(
          student['id'], student['name'], student['email'], student['credit']);
    }).toList();
    notifyListeners();
  }

  Future<void> delete(int id) async {
    final db = await AppDB.database();
    db.delete('User_Details', where: 'id=?', whereArgs: [id]);
    
    notifyListeners();
  }

  Future<void> fetchAndSetTransfer() async {
    
    final dbList = await AppDB.getData('Transfer_Table');

   
    _transferList = dbList.map((transaction) {
      return Transfer(transaction['txnId'], transaction['transferFrom'],
          transaction['transferTo'], transaction['transferAmount']);
    }).toList();
    notifyListeners();
  }

  Future<void> userEdit({int fromId, int toId, int transAmount,int fromAmount,int toAmount}) async {
    final db = await AppDB.database();
  
  await db.rawUpdate('UPDATE User_Details SET credit = ? WHERE id = ?',[fromAmount,fromId]);
    await db.rawUpdate('UPDATE User_Details SET credit = ? WHERE id = ?',[toAmount,toId]).then((value) => fetchAndSet());
    notifyListeners();
  }
}
