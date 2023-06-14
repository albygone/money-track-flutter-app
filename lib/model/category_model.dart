import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  late String name;
  late IconData icon;

  CategoryModel(String inName, IconData inIcon) {
    name = inName;
    icon = inIcon;
  }
}
