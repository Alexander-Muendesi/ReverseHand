import 'package:flutter/material.dart';
import 'package:redux_comp/models/user_model.dart';

@immutable
class ConsumerModel extends UserModel {
  const ConsumerModel(String name, String email) : super(name, email);
}
