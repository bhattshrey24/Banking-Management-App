import 'package:provider/provider.dart';

class Transfer {
  int _txnId;
  String _transferFrom;
  String _transferTo;
  num _transferAmount;
  Transfer(
      this._txnId, this._transferFrom, this._transferTo, this._transferAmount);
  set txnId(int txnId) {
  
    this._txnId = txnId;
  }

  set transferFrom(String transferFrom) {
    this._transferFrom = transferFrom;
  }

  set transferTo(String transferTo) {
    this._transferTo = transferTo;
  }

  set transferAmount(num transferAmount) {
    
    this._transferAmount = transferAmount;
  }

  int get txnId => this._txnId; // this will return id to user
  String get transferFrom => this._transferFrom;

  String get transferTo => this._transferTo;
  num get transferAmount => this._transferAmount;
}
