import 'package:flutter/material.dart';

class User {
  int _id;
  String _name;
  String _email;
  num _credit;
  User(this._id, this._name, this._email, this._credit);
  set id(int id) {
   
    this._id = id;
  }

  set name(String name) {
    this._name = name;
  }

  set email(String email) {
    this._email = email;
  }

  set credit(num credit) {
   
    this._credit = credit;
  }

  int get id => this._id; 
  String get name => this._name;

  String get email => this._email;
  num get credit => this._credit;
}
