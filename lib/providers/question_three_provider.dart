import 'package:flutter/material.dart';

class QuestionThreeProvider extends ChangeNotifier {
  String selectedCountry = '';


  void setSelectedCountry(String item) {
    selectedCountry = item;
    notifyListeners();
  }
}
