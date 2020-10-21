import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/UserProvider.dart';

class TransferTable extends StatelessWidget {
  static const String routeName = 'TransferTable';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false)
            .fetchAndSetTransfer(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<UserProvider>(
                    child: Center(
                      child: Text(
                        'No transaction yet',
                        style: TextStyle(fontSize: 20, color: Colors.black45),
                      ),
                    ),
                    builder: (ctx, userDetails, ch) =>
                        userDetails.transferList.length <= 0
                            ? ch
                            : ListView.builder(
                                itemBuilder: (ctx, index) {
                                  print(userDetails.transferList.length);
                                
                                  return Card(
                                    elevation: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '${userDetails.transferList[index].transferFrom}'),
                                            Column(
                                              children: [
                                                Icon(Icons.arrow_right),
                                                Text(
                                                    '${userDetails.transferList[index].transferAmount} ₹'),
                                              ],
                                            ),
                                            Text(
                                                '${userDetails.transferList[index].transferTo}')
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: userDetails.transferList.length,
                              ),
                  ),
      ),
    );
  }
}

