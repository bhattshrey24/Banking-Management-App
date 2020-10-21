import 'package:bankingApp/Model/TransferStructure.dart';
import 'package:flutter/material.dart';
import '../Model/UserStructure.dart';
import 'package:provider/provider.dart';
import '../provider/UserProvider.dart';

class UserScreen extends StatefulWidget {
  static const routeName = 'UserScreen';

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Transfer txn = Transfer(
     
      0,
      '',
      '',
      0);

  int txnAmount = 0;
  List<User> userList = [];
  
  var currentSelectedUser;
  List<String> listOfUsers = [];
  bool _isInit = true;
  User user;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      print('initializing');
      User userArg = ModalRoute.of(context).settings.arguments as User;
      user = userArg;
      List<User> userListdum =
          Provider.of<UserProvider>(context, listen: false).list;
      userList = userListdum;
      if (userListdum.length == 0) {
      } else {
        currentSelectedUser = user.name;
     
        for (int i = 0; i < userListdum.length; i++) {
          listOfUsers.add(userListdum[i].name);
        }
      }
    }
    _isInit = false;
  }

  void onSave() {
    txn.transferFrom = user.name;
    txn.transferTo = currentSelectedUser;
    txn.transferAmount = txnAmount;
    User dummy =
        userList.firstWhere((element) => element.name == currentSelectedUser);

    Provider.of<UserProvider>(context, listen: false).addTransaction(txn).then(
      (value) {
        print('add student complete inside its then function');
       
      },
    );
    int fromAmt = user.credit - txnAmount;
    int toAmt = dummy.credit + txnAmount;
    Provider.of<UserProvider>(context, listen: false)
        .userEdit(
            fromAmount: fromAmt,
            toAmount: toAmt,
            fromId: user.id,
            toId: dummy.id)
        .then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name}'),
      ),
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Credit: ${user.credit} ₹',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Email Id :',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                )),
                            Text('${user.email}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Transfer To : ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            DropdownButton<String>(
                              dropdownColor: Colors.white,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              elevation: 20,
                              items: listOfUsers.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem));
                              }).toList(),
                              onChanged: (String valSelected) {
                                setState(
                                  () {
                                    currentSelectedUser = valSelected;
                                 
                                  },
                                );
                              },
                              value: currentSelectedUser,
                            ),
                          ],
                        ),
                        Card(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                    labelText: 'Enter Transfer Amount'),
                                onChanged: (val) {
                                  txnAmount = int.parse(val);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: RaisedButton.icon(
                          color: Colors.black87,
                          elevation: 10,
                          onPressed: () {
                          
                            onSave();
                          },
                          icon: Icon(Icons.money_off, color: Colors.white),
                          label: Text(
                            'Transfer',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
