import 'package:flutter/material.dart';
import '../Model/UserStructure.dart';
import '../Screen/UserScreen.dart';
import 'package:provider/provider.dart';
import '../provider/UserProvider.dart';
import '../Screen/UserInputForm.dart';

class AllUsersScreen extends StatefulWidget {
  static const String routeName = 'AllUserScreen';

  @override
  _AllUsersScreenState createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: FutureBuilder(
            future:
                Provider.of<UserProvider>(context, listen: false).fetchAndSet(),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<UserProvider>(
                    child: Center(
                      child: Text(
                        'Add User',
                        style: TextStyle(fontSize: 20, color: Colors.black45),
                      ),
                    ),
                    builder: (ctx, userDetails, ch) => userDetails
                                .list.length <=
                            0
                        ? ch
                        : ListView.builder(
                            itemBuilder: (ctx, index) {
                            
                              return ListTile(
                                leading: Icon(Icons.people),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(UserScreen.routeName,
                                          arguments: userDetails.list[index])
                                      .then((value1) {
                                    Future.delayed(Duration(seconds: 1))
                                        .then((value2) {
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Transfer Successful'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    });
                                  });
                                },
                                title: Text('${userDetails.list[index].name}'),
                                subtitle:
                                    Text('${userDetails.list[index].credit}'),
                                trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .delete(userDetails.list[index].id)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    }),
                              );
                            },
                            itemCount: userDetails.list.length,
                          ),
                  ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(UserInputForm.routeName);
              }),
        )
      ],
    );
  }
}
