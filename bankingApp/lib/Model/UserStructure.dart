import 'package:flutter/material.dart';

class User {
  int _id;
  String _name;
  String _email;
  num _credit;
  User(this._id, this._name, this._email, this._credit);
  set id(int id) {
    // this will set the id of the object , its return type is void cause we are not returning anything
    this._id = id;
  }

  set name(String name) {
    this._name = name;
  }

  set email(String email) {
    this._email = email;
  }

  set credit(num credit) {
    // this will set the id of the object , its return type is void cause we are not returning anything
    this._credit = credit;
  }

  int get id => this._id; // this will return id to user
  String get name => this._name;

  String get email => this._email;
  num get credit => this._credit;
}
