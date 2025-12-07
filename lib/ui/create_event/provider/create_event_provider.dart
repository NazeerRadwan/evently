import 'package:flutter/material.dart';

class CreatEventProvider extends ChangeNotifier {
  int selectedTap = 0;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void changeTapIndex(int index) {
    selectedTap = index;
    notifyListeners();
  }

  String? validateTitle(String? title) {
    if (title == null || title.isEmpty) {
      return "Should add event title";
    }
    return null;
  }
}
