import 'package:flutter/material.dart';

class QuestionOneProvider extends ChangeNotifier {
  String selectedItem = '';
  final TextEditingController controller = TextEditingController();


  void setSelectedItem(String item) {
    controller.text = item;
    selectedItem = item;
    notifyListeners();
  }
  @override
  void dispose() {
    selectedItem = "";
    controller.clear();
    super.dispose();
  }
}
