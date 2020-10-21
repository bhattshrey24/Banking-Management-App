import 'package:bankingApp/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/UserStructure.dart';

class UserInputForm extends StatefulWidget {
  static const routeName = 'UserInputForm';
  @override
  _UserInputFormState createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  final _userInputForm = GlobalKey<FormState>();
  User user = User(
      // maybe initializing id can create problem
      0,
      '',
      '',
      0);
  void _saveForm() {
    bool validate = _userInputForm.currentState.validate();
    if (!validate) {
      return;
    }
    _userInputForm.currentState.save();
    // print('$_storedImage is the value of stored image');
    Provider.of<UserProvider>(context, listen: false).addUser(user).then(
      (value) {
        print('add student complete inside its then function');
        //Navigator.pop(context, _editedDetails.name);
        Navigator.pop(context);
      },
    );

    // FocusScope.of(context).unfocus();
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Input form'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
            color: Colors.white,
          )
        ],
      ),
      body: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _userInputForm,
            child: SingleChildScrollView(
                child: Column(
              children: [
                TextFormField(
                  initialValue: '',
                  decoration: InputDecoration(labelText: 'name'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    user.name = value;
                  },
                ),
                TextFormField(
                  initialValue: '',
                  decoration: InputDecoration(labelText: 'email'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    user.email = value;
                  },
                ),
                TextFormField(
                  initialValue: '0',
                  decoration: InputDecoration(labelText: 'Credit'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    user.credit = double.parse(value);
                  },
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
